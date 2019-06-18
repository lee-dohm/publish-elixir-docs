#!/bin/sh

# Exit on failure
set -e

update_file()
{
  REGEX=$1
  REPLACEMENT=$2
  shift; shift;
  FILES=$@

  sed -E -i .backup "s/$REGEX/$REPLACEMENT/g" $FILES
}

# Get Rebar and Hex
echo "==> Locally-install Rebar and Hex"
mix local.rebar --force
mix local.hex --force

# Download the mix dependencies
echo "==> Install mix dependencies"
mix deps.get

# Tag version number with git hash
hash=$(echo "$GITHUB_SHA" | cut -c1-7)
update_file "version: \"([^\"]+)\"" "version: \"\1+$hash\"" mix.exs

# Generate the documentation
echo "==> Generate docs"
mix docs

# Create a temp directory
temp_dir="$HOME/temp-docs"
mkdir $temp_dir

# Copy the generated docs into the temp directory
cp -R doc/* $temp_dir/

# Change working dir to the temp directory
cd $temp_dir

# Push the generated docs to GitHub
echo "==> Push generated docs to GitHub"
remote_branch="gh-pages"
remote_repo="https://${GITHUB_TOKEN}@github.com/${GITHUB_REPOSITORY}.git"

git init
git remote add origin $remote_repo
git config user.email "$GITHUB_ACTOR@users.noreply.github.com"
git config user.name "$GITHUB_ACTOR"
git add .
git commit -m "Docs updated at $(date -u "+%Y-%m-%dT%H:%M:%SZ")"
git push --force origin master:$remote_branch

# Delete the temp directory
echo "==> Cleanup"
cd $GITHUB_WORKSPACE
rm -rf $temp_dir
