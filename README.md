# Ngobrolin

[![Open in GitHub Codespaces](https://github.com/codespaces/badge.svg)](https://github.com/codespaces/new?hide_repo_select=true&ref=main&repo=ngobrolin&machine=standardLinux32gb&devcontainer_path=.devcontainer%2Fdevcontainer.json)

Ngobrolin is a video podcast platform focused on delivering engaging tech content. This repository contains both the main Phoenix application and a Next.js reference implementation.

## Progress

- [x] Initial Phoenix application setup
- [x] Next.js reference implementation
- [x] Episode schema and LiveView setup
- [x] Basic Episode CRUD operations
- [x] Add episode number with auto-increment
- [x] Episode detail page with video player
- [x] Consistent styling between Phoenix and Next.js implementations
- [x] Phoenix main page layout
- [x] Search functionality
- [x] Navigation and routing
- [x] About page
- [x] Sponsor page
- [x] Podcast feed XML
   - [x] Audio file naming convention with video ID
   - [x] YouTube audio extraction using yt-dlp
   - [x] Episode download status tracking
   - [x] S3 storage integration for audio files
   - [x] Configure S3 public read access
- [x] Setup CI
- [x] Deploy
- [x] Add sync episodes routes 
- [ ] Meta tags, card and SEO stuff
- [ ] Episode descriptions using markdown files
- [ ] Add comment functionality

## Contributing

We welcome contributions to the Ngobrolin project! Here's how you can help:

### Reporting Issues

- Use the GitHub issue tracker to report bugs or suggest features
- Before creating an issue, please check if a similar one already exists
- Provide as much context as possible: screenshots, error messages, and steps to reproduce

### Pull Requests

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

### Development Guidelines

- Follow the existing code style and conventions
- Add tests for new features when applicable
- Update documentation as needed
- Be respectful and constructive in discussions

Even if you're not ready to contribute code, we value your feedback and ideas! Feel free to open discussions or suggest improvements through issues.

## Development

### Prerequisites

Before running the application, ensure you have the following installed:

* **Elixir** - The project requires Elixir 1.14 or later
  * See the [official Elixir installation guide](https://elixir-lang.org/install.html) for your operating system
  * You can also use version managers like [asdf](https://github.com/asdf-vm/asdf) to manage Elixir versions
* **PostgreSQL** - Required for the application database
  * PostgreSQL 13 or later is recommended
  * Make sure the PostgreSQL service is running before starting the application

### Starting the Server

#### GitHub Codespaces
This repository is configured for development in GitHub Codespaces:

1. Click the "Open in GitHub Codespaces" button at the top of this README
2. Wait for the container to build (includes Elixir, Node.js, and PostgreSQL)
3. The server will automatically start at port 4000
4. Access your application at the Codespaces forwarded port URL

For detailed information about the Codespaces setup, see [Codespaces Documentation](docs/CODESPACES.md).

#### Local Setup
To start your Phoenix server locally:

  * Run `mix setup` to install and setup dependencies
  * Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`
  * Run `mix ecto.migrate` to apply database migrations

#### Docker Development Environment
To use the Docker development environment with Docker Compose:

1. Copy the example environment file:
```bash
cp .env-example .env
```

2. Edit the `.env` file to add your API keys and credentials

3. Start the application with PostgreSQL:
```bash
# Start the application with PostgreSQL
docker-compose up

# Or build and start in detached mode
docker-compose up --build -d

# View logs
docker-compose logs -f

# Stop the services
docker-compose down
```

The Docker Compose setup:
1. Starts a PostgreSQL database
2. Builds and runs the application using Dockerfile.dev
3. Connects the app to the database automatically
4. Mounts your local directory to /app for hot reloading
5. Exposes the app on port 4000
6. Preserves PostgreSQL data between restarts

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](https://hexdocs.pm/phoenix/deployment.html).

## Learn more

  * Official website: https://www.phoenixframework.org/
  * Guides: https://hexdocs.pm/phoenix/overview.html
  * Docs: https://hexdocs.pm/phoenix
  * Forum: https://elixirforum.com/c/phoenix-forum
  * Source: https://github.com/phoenixframework/phoenix
