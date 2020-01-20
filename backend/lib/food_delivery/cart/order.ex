defmodule FoodDelivery.Cart.Order do
  use Ecto.Schema
  import Ecto.Changeset

  defimpl Jason.Encoder, for: [FoodDelivery.Cart.Order] do
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

  schema "orders" do
    field(:status, :string, default: "not_placed")
    belongs_to(:restaurant, FoodDelivery.Menu.Restaurant)
    belongs_to(:user, FoodDelivery.Users)
    many_to_many(:meals, FoodDelivery.Menu.Meal, join_through: FoodDelivery.Cart.OrderMeal)

    field(:placed_date, :utc_datetime)
    field(:canceled_date, :utc_datetime)
    field(:processing_date, :utc_datetime)
    field(:in_route_date, :utc_datetime)
    field(:delivered_date, :utc_datetime)
    field(:received_date, :utc_datetime)
    timestamps()
  end

  @required ~w(restaurant_id user_id)a
  @optional ~w()a
  # status placed_date canceled_date processing_date in_route_date delivered_date received_date
  @doc false
  def changeset(order, attrs) do
    order
    |> cast(attrs, @required ++ @optional)
    |> validate_required(@required)
  end

  defp do_change_status(order, attrs) do
    order
    |> cast(attrs, [:status])
    |> validate_required([:status])
    |> validate_inclusion(
      :status,
      ~w(not_placed placed canceled processing in_route delivered received)
    )
  end

  def change_status(order, status) do
    case {order.status, status} do
      {"not_placed", "placed"} -> do_change_status(order, %{"status" => "placed"})
      {"placed", "canceled"} -> do_change_status(order, %{"status" => "canceled"})
      {"placed", "processing"} -> do_change_status(order, %{"status" => "processing"})
      {"processing", "in_route"} -> do_change_status(order, %{"status" => "in_route"})
      {"in_route", "delivered"} -> do_change_status(order, %{"status" => "delivered"})
      {"delivered", "received"} -> do_change_status(order, %{"status" => "received"})
      {_, _} -> cast(order, %{}, [])
    end
  end
end
