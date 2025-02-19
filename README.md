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
- [ ] Phoenix main page layout
- [ ] Episode directory implementation
- [ ] Search functionality
- [ ] Navigation and routing

## TODO

1. Create Phoenix layout template
2. Implement navigation bar
3. Build episode directory component
4. Add footer with social links
5. Configure TailwindCSS with custom theme
6. Set up episode data structure
7. Implement search functionality

## Development

TBD: Add development setup instructions

To start your Phoenix server:

  * Run `mix setup` to install and setup dependencies
  * Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](https://hexdocs.pm/phoenix/deployment.html).

## Learn more

  * Official website: https://www.phoenixframework.org/
  * Guides: https://hexdocs.pm/phoenix/overview.html
  * Docs: https://hexdocs.pm/phoenix
  * Forum: https://elixirforum.com/c/phoenix-forum
  * Source: https://github.com/phoenixframework/phoenix
