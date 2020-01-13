defmodule FoodDelivery.Menu.Restaurant do
  use Ecto.Schema
  import Ecto.Changeset

  schema "restaurants" do
    field(:description, :string)
    field(:name, :string)
    belongs_to(:user, User)
    has_many(:meals, Meal)
    has_many(:orders, Order)

    timestamps()
  end

  @required ~w(name)a
  @optional ~w(description)a
  @doc false
  def changeset(restaurant, attrs) do
    restaurant
    |> cast(attrs, @required ++ @optional)
    |> validate_required(@required)
  end
end
