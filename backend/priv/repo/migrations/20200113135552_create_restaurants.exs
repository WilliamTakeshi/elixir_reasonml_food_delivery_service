defmodule FoodDelivery.Repo.Migrations.CreateRestaurants do
  use Ecto.Migration

  def change do
    create table(:restaurants) do
      add(:name, :string, null: false)
      add(:description, :string, default: "", size: 2047)
      add(:img_url, :string, default: "", size: 2047)
      add(:owner_id, references(:users, on_delete: :nothing), null: false)

      timestamps()
    end

    create(index(:restaurants, [:owner_id]))
  end
end
