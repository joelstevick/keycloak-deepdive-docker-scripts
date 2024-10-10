#!/bin/bash

# Script to start Keycloak with PostgreSQL database

# Define container name
CONTAINER_NAME="keycloak"

# Define environment variables
KEYCLOAK_ADMIN="admin"
KEYCLOAK_ADMIN_PASSWORD="admin"
KC_DB="postgres"
KC_DB_URL="jdbc:postgresql://host.docker.internal:5432/keycloak"
KC_DB_USERNAME="keycloak"
KC_DB_PASSWORD="keycloak"

# Check if the Keycloak container is already running
if [ "$(docker ps -q -f name=$CONTAINER_NAME)" ]; then
    echo "Stopping and removing running Keycloak container..."
    docker stop $CONTAINER_NAME
    docker rm $CONTAINER_NAME
fi

# Check if the container exists but is not running (and remove it)
if [ "$(docker ps -a -q -f name=$CONTAINER_NAME)" ]; then
    echo "Removing the existing Keycloak container..."
    docker rm $CONTAINER_NAME
fi

# Start Keycloak container in detached mode
echo "Starting Keycloak container..."
docker run -d \
  --name $CONTAINER_NAME \
  -p 8080:8080 \
  -e KEYCLOAK_ADMIN=$KEYCLOAK_ADMIN \
  -e KEYCLOAK_ADMIN_PASSWORD=$KEYCLOAK_ADMIN_PASSWORD \
  -e KC_DB=$KC_DB \
  -e KC_DB_URL=$KC_DB_URL \
  -e KC_DB_USERNAME=$KC_DB_USERNAME \
  -e KC_DB_PASSWORD=$KC_DB_PASSWORD \
  quay.io/keycloak/keycloak \
  start-dev

echo "Keycloak container '$CONTAINER_NAME' started successfully."