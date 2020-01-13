defmodule FoodDelivery.Menu.Restaurant do
  use Ecto.Schema
  import Ecto.Changeset

  schema "restaurants" do
    field :description, :string
    field :name, :string
    field :owner_id, :id

    timestamps()
  end

  @doc false
  def changeset(restaurant, attrs) do
    restaurant
    |> cast(attrs, [:name, :description])
    |> validate_required([:name, :description])
  end
end
