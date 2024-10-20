#!/bin/bash

# Script to run PostgreSQL container in detached mode

# Define container name
CONTAINER_NAME="postgres"

# Define environment variables
POSTGRES_USER="keycloak"
POSTGRES_PASSWORD="keycloak"
POSTGRES_DB="keycloak"

# Define volume name
VOLUME_NAME="postgres_data"

# Define port mapping
HOST_PORT="5432"
CONTAINER_PORT="5432"

# Check if the PostgreSQL container is already running
if [ "$(docker ps -q -f name=$CONTAINER_NAME)" ]; then
    echo "Stopping the existing PostgreSQL container '$CONTAINER_NAME'..."
    docker stop $CONTAINER_NAME
    docker rm $CONTAINER_NAME  # Optionally remove the container
fi

# Run PostgreSQL container in detached mode
docker run -d \
  --name $CONTAINER_NAME \
  -e POSTGRES_USER=$POSTGRES_USER \
  -e POSTGRES_PASSWORD=$POSTGRES_PASSWORD \
  -e POSTGRES_DB=$POSTGRES_DB \
  -v $VOLUME_NAME:/var/lib/postgresql/data \
  -p $HOST_PORT:$CONTAINER_PORT \
  postgres

# Output success message
echo "PostgreSQL container '$CONTAINER_NAME' is running in detached mode."