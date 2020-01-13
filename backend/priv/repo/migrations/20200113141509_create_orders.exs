defmodule FoodDelivery.Repo.Migrations.CreateOrders do
  use Ecto.Migration

  def change do
    create table(:orders) do
      add(:status, :string)
      add(:date, :utc_datetime)
      add(:restaurant_id, references(:restaurants, on_delete: :nothing))

      timestamps()
    end

    create(index(:orders, [:restaurant_id]))
  end
end
