defmodule FoodDelivery.Permission.Block do
  use Ecto.Schema
  import Ecto.Changeset

  defimpl Jason.Encoder, for: [FoodDelivery.Permission.Block] do
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

  schema "blocks" do
    belongs_to(:restaurant, FoodDelivery.Menu.Restaurant)
    belongs_to(:user, FoodDelivery.Users.User)

    timestamps()
  end

  @required ~w(user_id restaurant_id)a
  @doc false
  def changeset(block, attrs) do
    block
    |> cast(attrs, @required)
    |> validate_required(@required)
  end
end
