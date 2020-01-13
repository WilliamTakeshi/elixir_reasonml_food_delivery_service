use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :food_delivery, FoodDeliveryWeb.Endpoint,
  http: [port: 4002],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :food_delivery, FoodDelivery.Repo,
  username: "postgres",
  password: "postgres",
  database: "food_delivery_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox
