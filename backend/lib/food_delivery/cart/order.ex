defmodule FoodDelivery.Cart.Order do
  use Ecto.Schema
  import Ecto.Changeset

  schema "orders" do
    field(:date, :utc_datetime)
    field(:status, :string, default: "not_placed")
    belongs_to(:restaurant, Restaurant)
    many_to_many(:meals, Meal, join_through: OrderMeal)
    timestamps()
  end

  @doc false
  def changeset(order, attrs) do
    order
    |> cast(attrs, [:status, :date])
    |> validate_required([:status, :date])
    |> validate_inclusion(
      :status,
      ~w(not_placed placed canceled processing in_route delivered received)
    )
  end
end
