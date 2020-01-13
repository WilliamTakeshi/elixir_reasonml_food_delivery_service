defmodule FoodDeliveryWeb.RestaurantController do
  use FoodDeliveryWeb, :controller

  alias FoodDelivery.Menu
  alias FoodDelivery.Menu.Restaurant

  action_fallback FoodDeliveryWeb.FallbackController

  def index(conn, _params) do
    restaurants = Menu.list_restaurants()
    render(conn, "index.json", restaurants: restaurants)
  end

  def create(conn, %{"restaurant" => restaurant_params}) do
    with {:ok, %Restaurant{} = restaurant} <- Menu.create_restaurant(restaurant_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.restaurant_path(conn, :show, restaurant))
      |> render("show.json", restaurant: restaurant)
    end
  end

  def show(conn, %{"id" => id}) do
    restaurant = Menu.get_restaurant!(id)
    render(conn, "show.json", restaurant: restaurant)
  end

  def update(conn, %{"id" => id, "restaurant" => restaurant_params}) do
    restaurant = Menu.get_restaurant!(id)

    with {:ok, %Restaurant{} = restaurant} <- Menu.update_restaurant(restaurant, restaurant_params) do
      render(conn, "show.json", restaurant: restaurant)
    end
  end

  def delete(conn, %{"id" => id}) do
    restaurant = Menu.get_restaurant!(id)

    with {:ok, %Restaurant{}} <- Menu.delete_restaurant(restaurant) do
      send_resp(conn, :no_content, "")
    end
  end
end
