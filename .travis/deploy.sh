#!/bin/bash

# print outputs and exit on first failure
set -xe

if [ $TRAVIS_BRANCH == "master" ] ; then
    set -x	
    # setup ssh agent, git config and remote    
    openssl aes-256-cbc -K $encrypted_4dc565c56c51_key -iv $encrypted_4dc565c56c51_iv -in deploy-key.enc -out deploy-key -d
    rm deploy-key.enc # Don't need it anymore
    chmod 600 deploy-key
    mv deploy-key ~/.ssh/id_rsa

    # eval "$(ssh-agent -s)"
    # ssh-add ~/.ssh/deploy-key        
    # chmod 600 ~/.ssh/deploy-key 

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