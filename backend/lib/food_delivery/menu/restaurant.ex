defmodule FoodDelivery.Menu.Restaurant do
  use Ecto.Schema
  import Ecto.Changeset

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
