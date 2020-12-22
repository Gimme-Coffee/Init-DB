#!/bin/bash

echo "Removing directories..."

rm -fr sprites

echo "Creating directories..."

mkdir sprites

mkdir sprites/front
mkdir sprites/front-shiny

mkdir sprites/back
mkdir sprites/back-shiny

echo "Running script..."

python3 init.py