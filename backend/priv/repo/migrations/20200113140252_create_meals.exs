defmodule FoodDelivery.Repo.Migrations.CreateMeals do
  use Ecto.Migration

  def change do
    create table(:meals) do
      add(:name, :string)
      add(:description, :string)
      add(:price, :integer)
      add(:active, :boolean, default: false, null: false)
      add(:restaurant_id, references(:restaurants, on_delete: :nothing))

      timestamps()
    end

    create(index(:meals, [:restaurant_id]))
  end
end
