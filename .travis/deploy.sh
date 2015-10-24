#!/bin/bash

cd dist
git init

git remote add production deploy@tommymcgahee.com:interview
git config --global push.default simple
git config --global user.email "tommy.mcgahee@gmail.com"
git config --global user.name "deploy"

git add *
git commit -m "Deployed to production server"
git push --force --quiet production master > /dev/null