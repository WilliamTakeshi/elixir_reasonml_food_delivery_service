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

  @required ~w(name price active)a
  @optional ~w(description)a

  @doc false
  def changeset(meal, attrs) do
    meal
    |> cast(attrs, @required ++ @optional)
    |> validate_required(@required)
  end
end
