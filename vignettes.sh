#!/bin/bash
set -ev

# Pull requests and commits to other branches shouldn't try to deploy, just build to verify
if [ "$TRAVIS_PULL_REQUEST" != "false" -o "$TRAVIS_BRANCH" != "$SOURCE_BRANCH" ]; then
    echo "Skipping deploy; just doing a build."
    doCompile
    exit 0
fi


git config --global user.name "Karthik Ram (Travis-CI)"
git config --global user.email "karthik.ram@gmail.com"

git clone https://github.com/ropensci/ecoengine
cd ecoengine
git remote rm origin
git remote add origin https://username:${GH_TOKEN}@github.com/username/repo.git
git checkout gh-pages
git merge master
git push origin gh-pages
