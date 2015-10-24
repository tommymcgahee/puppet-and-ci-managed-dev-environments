#!/bin/bash

cd dist
git init
eval "$(ssh-agent -s)"
chmod 600 .travis/deploy_key 
ssh-add .travis/deploy_key
git remote add production deploy@tommymcgahee.com:interview
git config --global push.default simple
git config --global user.email "tommy.mcgahee@gmail.com"
git config --global user.name "deploy"
git commit -m "Deployed to production server"
git push --force --quiet production master > /dev/null
