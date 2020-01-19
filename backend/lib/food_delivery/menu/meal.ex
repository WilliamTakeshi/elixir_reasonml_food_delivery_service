defmodule FoodDelivery.Menu.Meal do
  use Ecto.Schema
  import Ecto.Changeset

  defimpl Jason.Encoder, for: [FoodDelivery.Menu.Meal] do
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

  schema "meals" do
    field(:active, :boolean, default: true)
    field(:description, :string, default: "")
    field(:img_url, :string, default: "")
    field(:name, :string)
    field(:price, :integer)
    belongs_to(:restaurant, FoodDelivery.Menu.Restaurant)

    many_to_many(:orders, FoodDelivery.Cart.Order, join_through: FoodDelivery.Cart.OrderMeal)

    timestamps()
  end

  @required ~w(name price active restaurant_id)a
  @optional ~w(description img_url)a

  @doc false
  def changeset(meal, attrs) do
    meal
    |> cast(attrs, @required ++ @optional)
    |> validate_required(@required)
  end
end
