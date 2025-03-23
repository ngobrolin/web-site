# Ngobrolin

Ngobrolin is a video podcast platform focused on delivering engaging tech content. This repository contains both the main Phoenix application and a Next.js reference implementation.

## Project Structure

- `/` - Main Phoenix/LiveView application
- `/docs/v0-ngobrolin-web/` - Next.js reference implementation

## Current Goals

1. Implement main page layout in Phoenix/LiveView matching the design of the Next.js implementation:
   - Navigation bar with logo, menu items, and search
   - Episode directory with grid layout
   - Footer with copyright and social links

2. Maintain consistent styling between Phoenix and Next.js implementations:
   - Color scheme: #1a203b (background), #6587ff (primary blue), #a76ab7 (accent purple)
   - Typography: Inter font, bold headings
   - Modern, clean layout with consistent spacing

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
- [ ] Feed xml
   - [ ] Download all audio to s3
   - [ ] Name audio file with video id
- [ ] Description from markdown file

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

## TODO

1. Add persistent mini-player while scrolling
2. Implement search and filtering functionality
3. Implement pagination for episode listing
4. Create navigation bar with search
5. Add footer with social links
6. Implement related episodes recommendations
7. Add comment section functionality

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
