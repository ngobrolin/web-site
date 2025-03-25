# Ngobrolin

Ngobrolin is a video podcast platform focused on delivering engaging tech content. This repository contains both the main Phoenix application and a Next.js reference implementation.

## Current Goals

1. Implement main page layout in Phoenix/LiveView matching the design of the Next.js implementation:
   - Navigation bar with logo, menu items, and search
   - Episode directory with grid layout
   - Footer with copyright and social links

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
- [ ] Episode descriptions using markdown files
- [ ] Add comment functionality

## Latest Changes

- Added Episode schema with fields: title, description, thumbnail_url, duration, published_at, youtube_id, view_count, status, and episode_number
- Implemented auto-incrementing episode numbers for new episodes
- Generated LiveView components for Episode listing and management
- Set up database migrations for episodes table
- Configured Episode routes in the router
- Enhanced episode detail page with video player, show notes, and social sharing
- Added view count tracking for episodes
- Improved episode detail page layout and responsiveness
- Integrated lite-youtube-embed for better video performance
- Updated episode detail page styling to match home page design system
- Implemented consistent border styles and color scheme across pages
- Enhanced typography with brand colors and font weights
- Reorganized episode detail layout for better visual hierarchy
- Updated action buttons to match global design pattern
- Localized UI text to Bahasa Indonesia for better user experience
- Implemented podcast feed infrastructure with audio extraction capabilities
- Added S3 storage integration for hosting podcast audio files


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

To start your Phoenix server:

  * Run `mix setup` to install and setup dependencies
  * Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`
  * Run `mix ecto.migrate` to apply database migrations

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](https://hexdocs.pm/phoenix/deployment.html).

## Learn more

  * Official website: https://www.phoenixframework.org/
  * Guides: https://hexdocs.pm/phoenix/overview.html
  * Docs: https://hexdocs.pm/phoenix
  * Forum: https://elixirforum.com/c/phoenix-forum
  * Source: https://github.com/phoenixframework/phoenix
