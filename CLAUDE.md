# CLAUDE.md - Instructions for Agentic Coding Assistants

## Commands
- Build/setup: `mix setup` (install deps, setup DB, build assets)
- Start server: `mix phx.server` 
- Run tests: `mix test`
- Run single test: `mix test path/to/test.exs:line_number`
- Format code: `mix format`
- Build assets: `mix assets.build`
- Deploy assets: `mix assets.deploy`
- Database migrations: `mix ecto.migrate`

## Code Style Guidelines
- Follow Elixir/Phoenix conventions in existing code
- Use Phoenix.LiveView.HTMLFormatter for HEEx templates
- Follow Neo-brutalist design system (see docs/PRD.md):
  - Bold visual elements, thick white borders, high contrast
  - Dark backgrounds, white/text, black text on white backgrounds
  - Uppercase, system sans-serif fonts, extra bold weight
  - Dramatic hover effects, scale transitions
  - Grid-based layouts with generous spacing
- Ensure WCAG 2.1 AA compliance for accessibility
- Use proper pattern matching and functional programming idioms
- Leverage LiveView for reactive UI updates
- When generating migrations, use `mix ecto.gen.migration <name>`
- Use plural form for context modules (e.g., "Users" for users table)
- Use singular form for schema modules (e.g., "User" for users table)
- Context files are usually inside a folder named after the resource (e.g., lib/ngobrolin/users.ex)
- Schema files are usually inside a folder named after the resource (e.g., lib/ngobrolin/users/user.ex)
- Prefer keyword-based queries over pipe-based queries
  - For example, use `from(u in User, where: u.age > 18, select: u)` over `User |> where(age: 18) |> select([u], u)`
- Use `dbg/1` to debug code.
- Always use LiveView
- Use `phx.gen.live` to generate live page or a new feature
- Use `phx.gen.schema` to generate a new schema and migration file
- If any of my requests are not clear, ask me to clarify.
- If you have better suggestions, feel free to suggest them.