#!/bin/bash

echo -e "\033[0;32mDeploying updates to GitHub...\033[0m"

if [[ $(git status -s) ]]
then
    echo "The working directory is dirty. Please commit any pending changes."
    exit 1;
fi

echo "Removing existing files..."
rm -rf public/*

# Build the project.
hugo -t beautifulhugo # if using a theme, replace with `hugo -t <YOURTHEME>`

# Go To Public folder
cd public
# Add changes to git.
git add .

# Commit changes.
msg="Published to GitHub Pages on `date`"
if [ $# -eq 1 ]
  then msg="$1"
fi
git commit -m "$msg"

# Push source and build repos.
git push origin gh-pages

# Come Back up to the Project Root
cd ..
