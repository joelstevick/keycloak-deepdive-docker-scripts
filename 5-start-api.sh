#!/bin/bash

# Step 1: Clone the repository
echo "Cloning the repository..."
git clone https://github.com/joelstevick/keycloak-deepdive-api.git

# Step 2: Change to the project directory
cd keycloak-deepdive-api || { echo "Directory not found!"; exit 1; }

# Step 3: Build the Docker image
echo "Building the Docker image..."
docker build -t my-fastapi-app .

# Step 4: Check if the container exists
if [ "$(docker ps -aq -f name=my-fastapi-app)" ]; then
    echo "Stopping and removing the existing container..."
    docker stop my-fastapi-app
    docker rm my-fastapi-app
fi

# Step 5: Run the Docker container in detached mode
echo "Running the Docker container on port 8200..."
docker run -d --name my-fastapi-app -p 8200:8200 my-fastapi-app

echo "Setup complete! The application is running on http://localhost:8200"