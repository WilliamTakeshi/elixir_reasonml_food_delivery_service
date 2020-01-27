defmodule FoodDeliveryWeb.RestaurantController do
  use FoodDeliveryWeb, :controller

  alias FoodDelivery.Menu
  alias FoodDelivery.Menu.Restaurant

  action_fallback(FoodDeliveryWeb.FallbackController)

  def index(conn, _params) do
    user = Pow.Plug.current_user(conn)

    restaurants = Menu.list_restaurants(user)
    render(conn, "index.json", restaurants: restaurants)
  end

  def create(conn, %{"restaurant" => restaurant_params}) do
    user = Pow.Plug.current_user(conn)
    restaurant_params = Map.put(restaurant_params, "owner_id", user.id)

    with :ok <-
           Bodyguard.permit(FoodDelivery.Policy, :create_restaurant, user, restaurant_params),
         {:ok, %Restaurant{} = restaurant} <- Menu.create_restaurant(restaurant_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.restaurant_path(conn, :show, restaurant))
      |> render("show.json", restaurant: restaurant)
    end
  end

  def show(conn, %{"id" => id}) do
    user = Pow.Plug.current_user(conn)

    with [restaurant] <- Menu.get_restaurant_with_meals(id, user) do
      render(conn, "show.json", restaurant: restaurant)
    end
  end

  def update(conn, %{"id" => id, "restaurant" => restaurant_params}) do
    user = Pow.Plug.current_user(conn)

    with {:ok, restaurant} <- Menu.get_restaurant(id, user),
         :ok <- Bodyguard.permit(FoodDelivery.Policy, :update_restaurant, user, restaurant),
         {:ok, %Restaurant{} = restaurant} <-
           Menu.update_restaurant(restaurant, restaurant_params) do
      render(conn, "show.json", restaurant: restaurant)
    end
  end

  def delete(conn, %{"id" => id}) do
    user = Pow.Plug.current_user(conn)

    with {:ok, restaurant} <- Menu.get_restaurant(id, user),
         :ok <- Bodyguard.permit(FoodDelivery.Policy, :delete_restaurant, user, restaurant),
         {:ok, %Restaurant{}} <- Menu.delete_restaurant(restaurant) do
      send_resp(conn, :no_content, "")
    end
  end
end
