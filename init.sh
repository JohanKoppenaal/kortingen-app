#!/bin/bash

# Check if project name is provided
if [ -z "$1" ]; then
    echo "Please provide a project name"
    echo "Usage: ./init.sh project-name"
    exit 1
fi

PROJECT_NAME=$1

# Create Symfony project using composer
docker run --rm -v $(pwd):/app composer create-project symfony/skeleton:"6.3.*" $PROJECT_NAME

cd $PROJECT_NAME

# Copy Docker configuration
cp -r ../docker .
cp ../docker-compose.yml .
cp ../Makefile .

# Initialize Git repository
git init

# Create initial commit
git add .
git commit -m "Initial commit"

# Start the environment
make install

echo "Project $PROJECT_NAME has been created and initialized!"
echo "You can now cd into $PROJECT_NAME and run 'make dev' to start development"
