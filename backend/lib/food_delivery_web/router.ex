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
    post("/reset_password", ResetPasswordController, :create)
    post("/reset_password/update", ResetPasswordController, :update)

    resources("/confirm_email", ConfirmationController, only: [:show])
  end

  scope "/api/v1", FoodDeliveryWeb do
    # pipe_through([:api])
    pipe_through([:api, :api_protected])

    get("/me", SessionController, :me)

    resources("/restaurants", RestaurantController, except: [:new, :edit]) do
      resources("/meals", MealController, except: [:new, :edit])
      resources("/blocks", BlockController, except: [:new, :edit, :update])
    end

    resources("/orders", OrderController, except: [:new, :edit])
    post("/orders/:id/:status", OrderController, :change_status)

    # Your protected API endpoints here
  end
end
