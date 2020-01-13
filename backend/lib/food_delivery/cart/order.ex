defmodule FoodDelivery.Cart.Order do
  use Ecto.Schema
  import Ecto.Changeset

  schema "orders" do
    field(:date, :utc_datetime)
    field(:status, :string, default: "not_placed")
    field(:restaurant_id, :id)
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
