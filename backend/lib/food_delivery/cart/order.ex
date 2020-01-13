defmodule FoodDelivery.Cart.Order do
  use Ecto.Schema
  import Ecto.Changeset

  schema "orders" do
    field(:status, :string, default: "not_placed")
    belongs_to(:restaurant, Restaurant)
    many_to_many(:meals, Meal, join_through: OrderMeal)

    field(:placed_date, :utc_datetime)
    field(:canceled_date, :utc_datetime)
    field(:processing_date, :utc_datetime)
    field(:in_route_date, :utc_datetime)
    field(:delivered_date, :utc_datetime)
    field(:received_date, :utc_datetime)
    timestamps()
  end

  @required ~w(restaurant_id user_id)a
  @optional ~w(status placed_date canceled_date processing_date in_route_date delivered_date received_date)a
  @doc false
  def changeset(order, attrs) do
    order
    |> cast(attrs, @required ++ @optional)
    |> validate_required(@required)
    |> validate_inclusion(
      :status,
      ~w(not_placed placed canceled processing in_route delivered received)
    )
  end
end
