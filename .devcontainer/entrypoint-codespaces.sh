#!/bin/bash
# Codespaces entrypoint script

cd /app

# Clean any previous builds to avoid OTP version conflicts
if [ -n "$CODESPACES" ]; then
  echo "Setting up for GitHub Codespaces environment..."
  rm -rf _build
fi

# Configure database connection
if [ -n "$DATABASE_HOST" ]; then
  echo "Using PostgreSQL at $DATABASE_HOST"
  
  # Directly update the dev.exs file to use the correct connection info
  sed -i "s/hostname: \"localhost\"/hostname: \"$DATABASE_HOST\"/" config/dev.exs
  sed -i "s/username: \"riza\"/username: \"${DATABASE_USER:-postgres}\"/" config/dev.exs
  sed -i "s/password: \"empty\"/password: \"${DATABASE_PASSWORD:-postgres}\"/" config/dev.exs
  sed -i "s/database: \"ngobrolin_dev\"/database: \"${DATABASE_NAME:-ngobrolin_dev}\"/" config/dev.exs
  
  # Modify the endpoint config to listen on all interfaces
  sed -i "s/ip: {127, 0, 0, 1}/ip: {0, 0, 0, 0}/" config/dev.exs
  
  # Wait for PostgreSQL to be ready
  timeout=60
  countdown=$timeout
  echo "Waiting for PostgreSQL to be ready..."
  while ! pg_isready -h $DATABASE_HOST -U ${DATABASE_USER:-postgres} -d ${DATABASE_NAME:-ngobrolin_dev} && [ $countdown -gt 0 ]; do
    countdown=$((countdown-1))
    echo "Waiting for PostgreSQL... ${countdown}s remaining"
    sleep 1
  done
  if [ $countdown -eq 0 ]; then
    echo "Timed out waiting for PostgreSQL!"
    exit 1
  fi
  echo "PostgreSQL is ready!"
fi

# Install dependencies
mix deps.get

# Setup the application with proper database initialization
echo "Running database setup..."
mix ecto.setup

# Build and compile assets
echo "Building assets..."
mix assets.build

# Start the Phoenix server
echo "Starting Phoenix server..."
exec mix phx.server