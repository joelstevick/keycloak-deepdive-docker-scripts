#!/bin/bash

# Script to start pgAdmin container

# Define container name
CONTAINER_NAME="pgadmin4"

# Define environment variables
PGADMIN_DEFAULT_EMAIL="admin@admin.com"
PGADMIN_DEFAULT_PASSWORD="admin"

# Define volume name (use the existing volume or change as needed)
VOLUME_NAME="pgadmin_data"

# Define port mapping (host port:container port)
HOST_PORT="8081"
CONTAINER_PORT="80"

# Check if the pgAdmin container is already running
if [ "$(docker ps -q -f name=$CONTAINER_NAME)" ]; then
    echo "pgAdmin container '$CONTAINER_NAME' is already running."
else
    # Start pgAdmin container in detached mode
    echo "Starting pgAdmin container..."
    docker run -d \
      --name $CONTAINER_NAME \
      -e PGADMIN_DEFAULT_EMAIL=$PGADMIN_DEFAULT_EMAIL \
      -e PGADMIN_DEFAULT_PASSWORD=$PGADMIN_DEFAULT_PASSWORD \
      -v $VOLUME_NAME:/var/lib/pgadmin \
      -p $HOST_PORT:$CONTAINER_PORT \
      dpage/pgadmin4

    echo "pgAdmin container '$CONTAINER_NAME' started successfully."
    echo "Access pgAdmin at http://localhost:$HOST_PORT"
fi