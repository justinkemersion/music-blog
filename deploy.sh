#!/bin/bash
cd ~/Projects/music-blog
rm -rf public && git submodule update --init --recursive
hugo
cd public
git add .
git commit -m "Deploy site $(date -I)"
git push origin main
cd ..
git add public
git commit -m "Update submodule"
git push origin main
