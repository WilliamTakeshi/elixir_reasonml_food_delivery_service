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
    field(:description, :string, default: "", size: 2047)
    field(:img_url, :string, default: "", size: 2047)
    belongs_to(:user, FoodDelivery.Users.User, foreign_key: :owner_id)
    has_many(:meals, FoodDelivery.Menu.Meal)
    has_many(:orders, FoodDelivery.Cart.Order)
    has_many(:blocks, FoodDelivery.Permission.Block)

    timestamps()
  end

  @required ~w(name owner_id)a
  @optional ~w(description img_url)a
  @doc false
  def changeset(restaurant, attrs) do
    restaurant
    |> cast(attrs, @required ++ @optional)
    |> validate_required(@required)
  end

  @update ~w(name description img_url)a
  @doc false
  def update_changeset(restaurant, attrs) do
    restaurant
    |> cast(attrs, @update)
    |> validate_required(@update)
  end
end
