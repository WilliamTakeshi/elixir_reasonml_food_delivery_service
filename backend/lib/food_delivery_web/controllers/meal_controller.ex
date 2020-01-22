defmodule FoodDeliveryWeb.MealController do
  use FoodDeliveryWeb, :controller

  alias FoodDelivery.Menu
  alias FoodDelivery.Menu.Meal

  action_fallback(FoodDeliveryWeb.FallbackController)

  def index(conn, _params) do
    meals = Menu.list_meals()
    render(conn, "index.json", meals: meals)
  end

  def create(conn, %{"meal" => meal_params, "restaurant_id" => restaurant_id}) do
    user = Pow.Plug.current_user(conn)

    meal_params = Map.put(meal_params, "restaurant_id", restaurant_id)

    with {:ok, restaurant} <- Menu.get_restaurant(restaurant_id),
         :ok <- Bodyguard.permit(FoodDelivery.Policy, :create_meal, user, restaurant),
         {:ok, %Meal{} = meal} <- Menu.create_meal(meal_params) do
      conn
      |> put_status(:created)
      |> put_resp_header(
        "location",
        Routes.restaurant_meal_path(conn, :show, restaurant_id, meal)
      )
      |> render("show.json", meal: meal)
    end
  end

  def show(conn, %{"id" => id, "restaurant_id" => restaurant_id}) do
    with {:ok, meal} <- Menu.get_meal(id, restaurant_id) do
      render(conn, "show.json", meal: meal)
    end
  end

  def update(conn, %{"id" => id, "meal" => meal_params, "restaurant_id" => restaurant_id}) do
    user = Pow.Plug.current_user(conn)

    with {:ok, restaurant} <- Menu.get_restaurant(restaurant_id),
         :ok <- Bodyguard.permit(FoodDelivery.Policy, :update_meal, user, restaurant),
         {:ok, meal} <- Menu.get_meal(id, restaurant_id),
         {:ok, %Meal{} = meal} <- Menu.update_meal(meal, meal_params) do
      render(conn, "show.json", meal: meal)
    end
  end

  def delete(conn, %{"id" => id, "restaurant_id" => restaurant_id}) do
    user = Pow.Plug.current_user(conn)

    with {:ok, restaurant} <- Menu.get_restaurant(restaurant_id),
         :ok <- Bodyguard.permit(FoodDelivery.Policy, :delete_meal, user, restaurant),
         {:ok, meal} <- Menu.get_meal(id, restaurant_id),
         {:ok, %Meal{}} <- Menu.delete_meal(meal) do
      send_resp(conn, :no_content, "")
    end
  end
end
