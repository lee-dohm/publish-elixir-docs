#!/bin/sh

# Exit on failure
set -e

# Get Rebar and Hex
mix local.rebar --force
mix local.hex --force

# Download the mix dependencies
mix deps.get

# Generate the documentation
mix docs

# Create a temp directory
temp_dir="$HOME/temp-docs"
mkdir $temp_dir

# Copy the generated docs into the temp directory
cp -R doc/* $temp_dir/

# Change working dir to the temp directory
cd $temp_dir

# Push the generated docs to GitHub
remote_branch="gh-pages"

git init
git remote add origin "git@github.com:$GITHUB_REPOSITORY.git"
git checkout --orphan $remote_branch
git config user.email "$GITHUB_ACTOR@users.noreply.github.com"
git config user.name "$GITHUB_ACTOR"
git add .
git commit -m "Docs updated at $(date -u "+%Y-%m-%dT%H:%M:%SZ")"
git push origin $remote_branch --force

# Delete the temp directory
cd $GITHUB_WORKSPACE
rm -rf $temp_dir
