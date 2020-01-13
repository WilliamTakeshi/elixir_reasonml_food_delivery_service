defmodule FoodDelivery.Menu.Meal do
  use Ecto.Schema
  import Ecto.Changeset

  schema "meals" do
    field(:active, :boolean, default: true)
    field(:description, :string)
    field(:name, :string)
    field(:price, :integer)
    belongs_to(:restaurant, Restaurant)

    many_to_many(:orders, Order, join_through: OrderMeal)

    timestamps()
  end

  @doc false
  def changeset(meal, attrs) do
    meal
    |> cast(attrs, [:name, :description, :price, :active])
    |> validate_required([:name, :description, :price])
  end
end
