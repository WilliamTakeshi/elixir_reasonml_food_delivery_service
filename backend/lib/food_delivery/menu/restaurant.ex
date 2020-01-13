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

  @doc false
  def changeset(restaurant, attrs) do
    restaurant
    |> cast(attrs, [:name, :description])
    |> validate_required([:name, :description])
  end
end
