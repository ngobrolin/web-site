import Config

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
config :ngobrolin, Ngobrolin.Repo,
  # Note: The url configuration automatically includes the test partition suffix
  # if MIX_TEST_PARTITION is set, so we don't need to add it manually here.
  # Ecto will append it if the env var is present.
  url: System.get_env("DATABASE_URL", "ecto://postgres:postgres@localhost/ngobrolin_test"),
  pool: Ecto.Adapters.SQL.Sandbox,
  pool_size: 1 # Keep pool size small for tests

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :ngobrolin, NgobrolinWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "MCfTj12vXT2zvgUvi5Nh0NjMfjfU4wzx4RYX5XAsoqgnB7x5aI4jBg7WHq3zIOIA",
  server: false

# In test we don't send emails
config :ngobrolin, Ngobrolin.Mailer, adapter: Swoosh.Adapters.Test

# Disable swoosh api client as it is only required for production adapters
config :swoosh, :api_client, false

# Print only warnings and errors during test
config :logger, level: :warning

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime

# Enable helpful, but potentially expensive runtime checks
config :phoenix_live_view,
  enable_expensive_runtime_checks: true
