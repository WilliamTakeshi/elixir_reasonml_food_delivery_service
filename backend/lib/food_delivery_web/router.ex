defmodule FoodDeliveryWeb.Router do
  use FoodDeliveryWeb, :router

  pipeline :api do
    plug(:accepts, ["json"])
    plug(FoodDeliveryWeb.APIAuthPlug, otp_app: :food_delivery)
  end

  pipeline :api_protected do
    plug(Pow.Plug.RequireAuthenticated, error_handler: FoodDeliveryWeb.APIAuthErrorHandler)
  end

  scope "/api/v1", FoodDeliveryWeb do
    pipe_through(:api)

    resources("/registration", RegistrationController, singleton: true, only: [:create])
    resources("/session", SessionController, singleton: true, only: [:create, :delete])
    post("/session/renew", SessionController, :renew)
  end

  scope "/api/v1", FoodDeliveryWeb do
    pipe_through([:api, :api_protected])

    # Your protected API endpoints here
  end
end
