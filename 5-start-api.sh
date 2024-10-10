#!/bin/bash

# Step 1: Check if the directory already exists and delete it
if [ -d "keycloak-deepdive-api" ]; then
    echo "Directory 'keycloak-deepdive-api' exists. Deleting it..."
    rm -rf keycloak-deepdive-api
fi

# Step 2: Clone the repository
echo "Cloning the repository..."
git clone https://github.com/joelstevick/keycloak-deepdive-api.git

# Step 3: Change to the project directory
cd keycloak-deepdive-api || { echo "Directory not found!"; exit 1; }

# Step 4: Build the Docker image
echo "Building the Docker image..."
docker build -t my-fastapi-app .

# Step 5: Check if the container exists
if [ "$(docker ps -aq -f name=my-fastapi-app)" ]; then
    echo "Stopping and removing the existing container..."
    docker stop my-fastapi-app
    docker rm my-fastapi-app
fi

# Step 6: Run the Docker container in detached mode
echo "Running the Docker container on port 8200..."
docker run -d --name my-fastapi-app --network my_network -p 8200:8200 my-fastapi-app

echo "Setup complete! The application is running on http://localhost:8200"