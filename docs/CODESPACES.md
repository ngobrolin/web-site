# GitHub Codespaces Setup

This project is configured to work seamlessly with GitHub Codespaces, providing a complete development environment in the cloud.

## Features

- **Complete Development Environment**: Elixir, PostgreSQL, and all dependencies pre-configured
- **VS Code Integration**: Recommended extensions automatically installed
- **Automated Setup**: Database initialization and Phoenix server automatically started
- **Port Forwarding**: Web application accessible via forwarded ports

## Getting Started

1. Click the "Open in GitHub Codespaces" button in the README
2. Wait for the container to build (this may take a few minutes for the first time)
3. Access your application at the URL shown in the Ports tab

## Configuration

The Codespaces configuration is defined in the following files:

- `.devcontainer/devcontainer.json`: Main configuration file for Codespaces
- `.devcontainer/entrypoint-codespaces.sh`: Setup script that runs when the container starts
- `docker-compose.yml`: Defines services (app and PostgreSQL)
- `Dockerfile.dev`: Base container definition

## Environment Variables

The following environment variables are automatically set:

- `DATABASE_HOST=postgres`
- `DATABASE_USER=postgres`
- `DATABASE_PASSWORD=postgres`
- `DATABASE_NAME=ngobrolin_dev`

## Troubleshooting

If you encounter issues with Codespaces:

1. Check the terminal output for any error messages
2. Verify that PostgreSQL is running with `docker ps`
3. Check database connectivity with `pg_isready -h postgres -U postgres`
4. Restart the Codespace if necessary

## Manual Setup

If you need to manually set up the environment:

```bash
# Install dependencies
mix deps.get

# Setup database
mix ecto.setup

# Build assets
mix assets.build

# Start server
mix phx.server
```

## Additional Resources

- [GitHub Codespaces Documentation](https://docs.github.com/en/codespaces)
- [Phoenix Framework Documentation](https://hexdocs.pm/phoenix/overview.html)