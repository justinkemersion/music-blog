#!/bin/bash
set -e

cd ~/Projects/music-blog
echo "Building Hugo site..."
hugo --gc

echo "Updating public submodule..."
rm -rf public
git submodule update --init --recursive
cd public
git add .
git commit -m "Deploy site $(date -I)" || echo "No changes to commit in public"
git push origin main

cd ..
echo "Updating main repo..."
git add public
git commit -m "Update public submodule" || echo "No submodule changes"
git push origin main

echo "Deployment complete!"
