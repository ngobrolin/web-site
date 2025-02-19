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
- [ ] Phoenix main page layout
- [ ] Search functionality
- [ ] Navigation and routing
- [ ] Styling and UI components

## Latest Changes

- Added Episode schema with fields: title, description, thumbnail_url, duration, published_at, youtube_id, view_count, and status
- Generated LiveView components for Episode listing and management
- Set up database migrations for episodes table
- Configured Episode routes in the router

## TODO

1. Implement episode grid layout component
2. Add thumbnail preview and YouTube video integration
3. Style episode cards according to the design
4. Add search and filtering functionality
5. Implement episode detail page with video player
6. Add pagination for episode listing
7. Create navigation bar with search
8. Add footer with social links

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
