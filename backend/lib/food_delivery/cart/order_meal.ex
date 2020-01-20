defmodule FoodDelivery.Cart.OrderMeal do
  use Ecto.Schema
  import Ecto.Changeset

  schema "orders_meals" do
    belongs_to(:order, FoodDelivery.Cart.Order)
    belongs_to(:meal, FoodDelivery.Menu.Meal)
    field(:qty, :integer)

    timestamps()
  end

  @required ~w(order_id meal_id qty)a
  @optional ~w()a
  @doc false
  def changeset(order_meal, attrs) do
    order_meal
    |> cast(attrs, @required ++ @optional)
    |> validate_required(@required)
  end
end
