#!/bin/bash
set -e  # Exit on error

cd ~/Projects/music-blog
echo "Building Hugo site..."
hugo --gc  # Build site and clean cache

echo "Updating public submodule..."
rm -rf public  # Remove existing public directory
git submodule update --init --recursive  # Reinitialize submodules
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
