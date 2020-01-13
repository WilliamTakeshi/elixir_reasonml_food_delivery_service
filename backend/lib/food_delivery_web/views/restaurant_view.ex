defmodule FoodDeliveryWeb.RestaurantView do
  use FoodDeliveryWeb, :view
  alias FoodDeliveryWeb.RestaurantView

  def render("index.json", %{restaurants: restaurants}) do
    %{data: render_many(restaurants, RestaurantView, "restaurant.json")}
  end

  def render("show.json", %{restaurant: restaurant}) do
    %{data: render_one(restaurant, RestaurantView, "restaurant.json")}
  end

  def render("restaurant.json", %{restaurant: restaurant}) do
    %{id: restaurant.id,
      name: restaurant.name,
      description: restaurant.description}
  end
end
