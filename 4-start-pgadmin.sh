#!/bin/bash

# Script to start pgAdmin with a pre-configured PostgreSQL server

# Define container name
CONTAINER_NAME="pgadmin4"

# Define environment variables
PGADMIN_DEFAULT_EMAIL="admin@admin.com"
PGADMIN_DEFAULT_PASSWORD="admin"

# Define volume name and path to the pre-configured server JSON file
VOLUME_NAME="pgadmin_data"
SERVERS_JSON_PATH="./servers.json"

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
      -v $SERVERS_JSON_PATH:/pgadmin4/servers.json \
      -p $HOST_PORT:$CONTAINER_PORT \
      dpage/pgadmin4

    # Copy the servers.json file into the pgAdmin configuration directory
    docker exec $CONTAINER_NAME sh -c 'cp /pgadmin4/servers.json /var/lib/pgadmin/pgadmin4/servers.json'

    echo "pgAdmin container '$CONTAINER_NAME' started successfully with pre-configured PostgreSQL server."
    echo "Access pgAdmin at http://localhost:$HOST_PORT"
fi