defmodule FoodDelivery.Cart.OrderMeal do
  use Ecto.Schema
  import Ecto.Changeset

  defimpl Jason.Encoder, for: [FoodDelivery.Cart.OrderMeal] do
    def encode(struct, opts) do
      Enum.reduce(Map.from_struct(struct), %{}, fn
        {:__meta__, _}, acc -> acc
        {:__struct__, _}, acc -> acc
        {_, %Ecto.Association.NotLoaded{}}, acc -> acc
        {k, v}, acc -> Map.put(acc, k, v)
      end)
      |> Jason.Encode.map(opts)
    end
  end

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
