#!/bin/bash

# Script to initialize Docker volume for PostgreSQL persistence

# Define volume name and network name
VOLUME_NAME="postgres_data"
NETWORK_NAME="my_network"

# Function to check if volume exists
volume_exists() {
  docker volume inspect $VOLUME_NAME > /dev/null 2>&1
}

# Function to create Docker volume
create_volume() {
  echo "Creating Docker volume '$VOLUME_NAME'..."
  docker volume create $VOLUME_NAME
  echo "Docker volume '$VOLUME_NAME' created."
}

# Function to remove Docker volume (optional)
remove_volume() {
  echo "Removing existing Docker volume '$VOLUME_NAME'..."
  docker volume rm $VOLUME_NAME
  echo "Docker volume '$VOLUME_NAME' removed."
}

# Function to check if the network exists
network_exists() {
  docker network inspect $NETWORK_NAME > /dev/null 2>&1
}

# Function to create Docker network
create_network() {
  echo "Creating Docker network '$NETWORK_NAME'..."
  docker network create $NETWORK_NAME
  echo "Docker network '$NETWORK_NAME' created."
}

# Main script
echo "Initializing Docker volume and network for PostgreSQL..."

# Check if volume exists
if volume_exists; then
  echo "Docker volume '$VOLUME_NAME' already exists."
  
  # Uncomment the following lines if you want to remove and recreate the volume:
  # remove_volume
  # create_volume
else
  # Create the volume if it doesn't exist
  create_volume
fi

# Check if network exists
if network_exists; then
  echo "Docker network '$NETWORK_NAME' already exists."
else
  # Create the network if it doesn't exist
  create_network
fi

echo "Docker volume and network initialization complete."