defmodule FoodDelivery.Cart.OrderMeal do
  use Ecto.Schema
  import Ecto.Changeset

  schema "orders_meals" do
    belongs_to(:order, Order)
    belongs_to(:meal, Meal)

    timestamps()
  end

  @doc false
  def changeset(order_meal, attrs) do
    order_meal
    |> cast(attrs, [])
    |> validate_required([])
  end
end
