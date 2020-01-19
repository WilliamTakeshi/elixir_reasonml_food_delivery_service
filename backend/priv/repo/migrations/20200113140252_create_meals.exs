defmodule FoodDelivery.Repo.Migrations.CreateMeals do
  use Ecto.Migration

  def change do
    create table(:meals) do
      add(:name, :string, null: false)
      add(:description, :string, default: "")
      add(:price, :integer, null: false)
      add(:active, :boolean, default: true, null: false)
      add(:restaurant_id, references(:restaurants, on_delete: :nothing), null: false)
      add(:img_url, :string, default: "")

      timestamps()
    end

    create(index(:meals, [:restaurant_id]))
  end
end
