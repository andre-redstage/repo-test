#!/bin/bash

# print outputs and exit on first failure
set -xe

if [ $TRAVIS_BRANCH == "master" ] ; then

	echo "Clears git information"
  	rm -rf .git

    # setup ssh agent, git config and remote
    git status # debug
    eval "$(ssh-agent -s)"
    ssh-add ~/.ssh/travis_rsa
    git remote -v
    git remote add deploy "ssh://travis@104.236.118.124://var/www/repotest"
    git config user.name "Travis CI"
    git config user.email "travis@test.com"

    # commit compressed files and push it to remote
    git status # debug
    git add .
    git status # debug
    git remote -v
    git commit -m "Deploy from Travis - build {$TRAVIS_BUILD_NUMBER}"
    git push -f deploy master
else

    echo "No deploy script for branch '$TRAVIS_BRANCH'"

fi