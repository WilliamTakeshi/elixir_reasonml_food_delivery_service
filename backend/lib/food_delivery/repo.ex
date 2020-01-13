defmodule FoodDelivery.Repo do
  use Ecto.Repo,
    otp_app: :food_delivery,
    adapter: Ecto.Adapters.Postgres
end
