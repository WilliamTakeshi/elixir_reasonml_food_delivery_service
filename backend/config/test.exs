use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :food_delivery, FoodDeliveryWeb.Endpoint,
  http: [port: 4002],
  server: false,
  front_end_reset_password_url: "http://localhost:8000/reset_password/{token}",
  front_end_email_confirm_url: "http://localhost:8000/confirm_email/{token}"

config :food_delivery, FoodDelivery.Mailer, adapter: Bamboo.TestAdapter

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :food_delivery, FoodDelivery.Repo,
  username: "postgres",
  password: "postgres",
  database: "food_delivery_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox

# Configure your mailer
config :food_delivery, FoodDeliveryWeb.PowMailer, adapter: Bamboo.TestAdapter
