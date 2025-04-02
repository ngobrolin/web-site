import Config

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
config :ngobrolin, Ngobrolin.Repo,
  username: System.get_env("POSTGRES_USER", "riza"),
  password: System.get_env("POSTGRES_PASSWORD", "empty"),
  hostname: System.get_env("POSTGRES_HOSTNAME", "localhost"),
  database:
    System.get_env("POSTGRES_DB", "ngobrolin_test#{System.get_env("MIX_TEST_PARTITION")}"),
  pool: Ecto.Adapters.SQL.Sandbox,
  pool_size: System.schedulers_online() * 2

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
