defmodule FoodDeliveryWeb.Router do
  use FoodDeliveryWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", FoodDeliveryWeb do
    pipe_through :api
  end
end
