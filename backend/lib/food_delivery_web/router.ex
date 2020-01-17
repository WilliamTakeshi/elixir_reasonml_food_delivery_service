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
    post("/reset-password", ResetPasswordController, :create)
    post("/reset-password/update", ResetPasswordController, :update)

    resources("/confirm-email", ConfirmationController, only: [:show])
  end

  scope "/api/v1", FoodDeliveryWeb do
    pipe_through([:api])
    # pipe_through([:api, :api_protected])

    resources("/restaurants", RestaurantController, except: [:new, :edit]) do
      resources("/meals", MealController, except: [:new, :edit])
    end

    resources("/orders", OrderController, except: [:new, :edit])

    # Your protected API endpoints here
  end
end
