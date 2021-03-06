# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :food_delivery,
  ecto_repos: [FoodDelivery.Repo]

# Configures the pow authentication
config :food_delivery, :pow,
  user: FoodDelivery.Users.User,
  repo: FoodDelivery.Repo,
  mailer_backend: FoodDeliveryWeb.PowMailer,
  web_mailer_module: FoodDeliveryWeb,
  extensions: [PowResetPassword, PowEmailConfirmation],
  controller_callbacks: Pow.Extension.Phoenix.ControllerCallbacks

# Configures the endpoint
config :food_delivery, FoodDeliveryWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "o4PJo2Pn0l6vRgKizx+1H0h3hgoq7zO+VUqB816U6tH7zIY6alJWaCjvLoiUX7Ut",
  render_errors: [view: FoodDeliveryWeb.ErrorView, accepts: ~w(json)],
  pubsub: [name: FoodDelivery.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
