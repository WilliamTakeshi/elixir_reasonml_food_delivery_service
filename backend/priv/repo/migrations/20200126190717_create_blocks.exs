defmodule FoodDelivery.Repo.Migrations.CreateBlocks do
  use Ecto.Migration

  def change do
    create table(:blocks) do
      add :restaurant_id, references(:restaurants, on_delete: :nothing)
      add :user_id, references(:users, on_delete: :nothing)

      timestamps()
    end

    create index(:blocks, [:restaurant_id])
    create index(:blocks, [:user_id])
  end
end
