#!/bin/bash

echo "Removing directories..."

rm -fr sprites

echo "Creating directories..."

mkdir sprites

mkdir sprites/front
mkdir sprites/front-shiny

mkdir sprites/back
mkdir sprites/back-shiny

echo "Setting super secret environment variables..."

export GOOGLE_APPLICATION_CREDENTIALS="./pokemon-editor-firebase-adminsdk-n8jkh-6dca834788.json"

echo "Running script..."

python3 init.py