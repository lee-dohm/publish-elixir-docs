#!/bin/sh

# Exit on failure
set -e

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
git init
git add .
git commit -m "Docs updated at $(date -u "+%Y-%m-%dT%H:%M:%SZ")"
git remote add origin "git@github.com:$GITHUB_REPOSITORY.git"
git push origin test-branch --force
