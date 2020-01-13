defmodule FoodDelivery.Repo.Migrations.CreateRestaurants do
  use Ecto.Migration

  def change do
    create table(:restaurants) do
      add(:name, :string, null: false)
      add(:description, :string)
      add(:owner_id, references(:users, on_delete: :nothing), null: false)

      timestamps()
    end

    create(index(:restaurants, [:owner_id]))
  end
end
