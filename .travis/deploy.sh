#!/bin/bash

# print outputs and exit on first failure
set -xe

if [ $TRAVIS_BRANCH == "master" ] ; then

	chmod 600 ~/.ssh/deploy-key	

    # setup ssh agent, git config and remote    
    eval "$(ssh-agent -s)"
    ssh-add ~/.ssh/deploy-key        
    git remote add deploy "travis@104.236.118.124:/var/www/repotest"
    git config user.name "Travis CI"
    git config user.email "travis@test.com"

    # commit compressed files and push it to remote    
    git push -f deploy master
    
    git add .
    git status # debug    
    git commit -m "Deploy from Travis - build {$TRAVIS_BUILD_NUMBER}"

    
    git push -f deploy master
else

    echo "No deploy script for branch '$TRAVIS_BRANCH'"

fi