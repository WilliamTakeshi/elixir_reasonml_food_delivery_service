defmodule FoodDelivery.Menu.Restaurant do
  use Ecto.Schema
  import Ecto.Changeset

  defimpl Jason.Encoder, for: [FoodDelivery.Menu.Restaurant] do
    def encode(struct, opts) do
      Enum.reduce(Map.from_struct(struct), %{}, fn
        {:__meta__, _}, acc -> acc
        {:__struct__, _}, acc -> acc
        {_k, %Ecto.Association.NotLoaded{}}, acc -> acc
        {k, v}, acc -> Map.put(acc, k, v)
      end)
      |> Jason.Encode.map(opts)
    end
  end

  schema "restaurants" do
    field(:name, :string)
    field(:description, :string, default: "")
    field(:img_url, :string, default: "")
    belongs_to(:user, User, foreign_key: :owner_id)
    has_many(:meals, FoodDelivery.Menu.Meal)
    has_many(:orders, FoodDelivery.Cart.Order)

    timestamps()
  end

  @required ~w(name)a
  @optional ~w(description img_url)a
  @doc false
  def changeset(restaurant, attrs) do
    restaurant
    |> cast(attrs, @required ++ @optional)
    |> validate_required(@required)
  end
end
