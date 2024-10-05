#!/bin/bash

# Script to stop and remove all Docker containers, volumes, images, and networks

# Warning and confirmation prompt
echo "WARNING: This action will completely reset Docker."
echo "This includes deleting your Keycloak server, demo apps, and all Docker containers, images, volumes, and networks."
read -p "Are you sure you want to proceed? (y/N): " confirm

if [[ "$confirm" == "y" || "$confirm" == "Y" ]]; then
    echo "Stopping all running containers..."
    docker stop $(docker ps -q)

    echo "Removing all containers..."
    docker rm $(docker ps -a -q)

    echo "Removing all Docker volumes..."
    docker volume rm $(docker volume ls -q)

    echo "Removing all Docker networks..."
    docker network rm $(docker network ls -q)

    echo "Removing all Docker images..."
    docker rmi $(docker images -q)

    echo "Docker reset complete. All containers, volumes, networks, and images have been removed."
else
    echo "Operation canceled. No changes were made."
fi