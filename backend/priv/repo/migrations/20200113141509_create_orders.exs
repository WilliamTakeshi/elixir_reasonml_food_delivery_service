defmodule FoodDelivery.Repo.Migrations.CreateOrders do
  use Ecto.Migration

  def change do
    create table(:orders) do
      add(:status, :string)
      add(:restaurant_id, references(:restaurants, on_delete: :nothing))
      add(:user_id, references(:users, on_delete: :nothing))
      add(:placed_date, :utc_datetime)
      add(:canceled_date, :utc_datetime)
      add(:processing_date, :utc_datetime)
      add(:in_route_date, :utc_datetime)
      add(:delivered_date, :utc_datetime)
      add(:received_date, :utc_datetime)

      timestamps()
    end

    create(index(:orders, [:restaurant_id]))
  end
end
