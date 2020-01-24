defmodule FoodDelivery.Repo.Migrations.CreateOrdersMeals do
  use Ecto.Migration

  def change do
    create table(:orders_meals) do
      add(:order_id, references(:orders, on_delete: :delete_all))
      add(:meal_id, references(:meals, on_delete: :nothing))
      add(:qty, :integer, null: false)
      timestamps()
    end

    create(index(:orders_meals, [:order_id]))
    create(index(:orders_meals, [:meal_id]))
  end
end
