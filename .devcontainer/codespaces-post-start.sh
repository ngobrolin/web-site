#!/bin/bash
# This script runs after Codespace creation to configure environment variables

echo "Configuring environment for GitHub Codespaces..."

# Set database configuration for Codespaces
echo "Setting up database environment variables..."
echo "DATABASE_HOST=postgres" >> $GITHUB_ENV
echo "DATABASE_USER=postgres" >> $GITHUB_ENV
echo "DATABASE_PASSWORD=postgres" >> $GITHUB_ENV
echo "DATABASE_NAME=ngobrolin_dev" >> $GITHUB_ENV

# Configure any other necessary environment variables
# Add any other environment variable requirements here

echo "Environment configured successfully!"