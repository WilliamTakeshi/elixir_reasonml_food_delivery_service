defmodule FoodDeliveryWeb.MealView do
  use FoodDeliveryWeb, :view
  alias FoodDeliveryWeb.MealView

  def render("index.json", %{meals: meals}) do
    %{data: render_many(meals, MealView, "meal.json")}
  end

  def render("show.json", %{meal: meal}) do
    %{data: render_one(meal, MealView, "meal.json")}
  end

  def render("meal.json", %{meal: meal}) do
    meal
  end
end
