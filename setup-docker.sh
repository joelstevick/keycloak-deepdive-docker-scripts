#!/bin/bash

# Make all scripts executable
echo "Making scripts executable..."
chmod +x 1-initialize-volume.sh
chmod +x 2-start-postgres.sh
chmod +x 3-start-keycloak.sh
chmod +x 4-start-pgadmin.sh

# Run the scripts in sequence
echo "Running scripts in sequence..."

echo "Initializing Docker volume..."
./1-initialize-volume.sh

echo "Starting PostgreSQL..."
./2-start-postgres.sh

echo "Starting Keycloak..."
./3-start-keycloak.sh

echo "Starting pgAdmin..."
./4-start-pgadmin.sh

echo "All scripts executed successfully."