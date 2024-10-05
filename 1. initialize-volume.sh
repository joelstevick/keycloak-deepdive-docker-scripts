#!/bin/bash

# Script to initialize Docker volume for PostgreSQL persistence

# Define volume name
VOLUME_NAME="postgres_data"

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

# Main script
echo "Initializing Docker volume for PostgreSQL..."

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

echo "Docker volume initialization complete."