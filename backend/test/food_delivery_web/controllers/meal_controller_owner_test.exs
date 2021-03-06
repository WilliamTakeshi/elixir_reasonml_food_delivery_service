defmodule FoodDeliveryWeb.MealControllerOwnerTest do
  use FoodDeliveryWeb.ConnCase

  alias FoodDelivery.Menu
  alias FoodDelivery.Menu.{Meal, Restaurant}
  alias FoodDelivery.Users.User

  alias FoodDelivery.Repo

  @create_rest_attrs %{
    description: "some description",
    name: "some restaurant name",
    img_url: "some img_url",
    owner_id: nil
  }

  @create_meal_attrs %{
    active: true,
    description: "some description",
    name: "some name",
    price: 42,
    restaurant_id: nil
  }
  @update_meal_attrs %{
    active: true,
    description: "some updated description",
    name: "some updated name",
    price: 43,
    restaurant_id: nil
  }
  @invalid_meal_attrs %{restaurant_id: nil, active: nil, description: nil, name: nil, price: nil}

  def fixture(:meal) do
    {:ok, owner} =
      Pow.Ecto.Context.create(
        %{
          email: "owner@example.com",
          password: "password",
          confirm_password: "password",
          role: "owner"
        },
        otp_app: :food_delivery
      )

    {:ok, _user} =
      Pow.Ecto.Context.create(
        %{
          email: "user@example.com",
          password: "password",
          confirm_password: "password",
          role: "user"
        },
        otp_app: :food_delivery
      )

    {:ok, restaurant} = Menu.create_restaurant(%{@create_rest_attrs | owner_id: owner.id})
    {:ok, meal} = Menu.create_meal(%{@create_meal_attrs | restaurant_id: restaurant.id})

    meal
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    setup [:create_meal]

    test "lists all meals", %{conn: conn} do
      user = Repo.get_by(User, email: "owner@example.com")
      conn = Pow.Plug.assign_current_user(conn, user, otp_app: :food_delivery)
      restaurant = Repo.get_by(Restaurant, name: "some restaurant name")

      conn = get(conn, Routes.restaurant_meal_path(conn, :index, restaurant.id))

      assert [
               %{
                 "active" => true,
                 "description" => "some description",
                 "name" => "some name",
                 "price" => 42
               }
             ] = json_response(conn, 200)["data"]
    end
  end

  describe "create meal" do
    setup [:create_meal]

    test "renders meal when data is valid", %{conn: conn} do
      user = Repo.get_by(User, email: "owner@example.com")
      conn = Pow.Plug.assign_current_user(conn, user, otp_app: :food_delivery)
      restaurant = Repo.get_by(Restaurant, name: "some restaurant name")

      conn =
        post(conn, Routes.restaurant_meal_path(conn, :create, restaurant.id),
          meal: @create_meal_attrs
        )

      assert %{"id" => id} = json_response(conn, 201)["data"]

      # conn = get(conn, Routes.restaurant_meal_path(conn, :show, restaurant.id, id))

      # assert %{
      #          "id" => id,
      #          "active" => true,
      #          "description" => "some description",
      #          "name" => "some name",
      #          "price" => 42
      #        } = json_response(conn, 201)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      user = Repo.get_by(User, email: "owner@example.com")
      conn = Pow.Plug.assign_current_user(conn, user, otp_app: :food_delivery)
      restaurant = Repo.get_by(Restaurant, name: "some restaurant name")

      conn =
        post(conn, Routes.restaurant_meal_path(conn, :create, restaurant.id),
          meal: @invalid_meal_attrs
        )

      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update meal" do
    setup [:create_meal]

    test "renders meal when data is valid", %{conn: conn, meal: %Meal{id: id} = meal} do
      user = Repo.get_by(User, email: "owner@example.com")
      conn = Pow.Plug.assign_current_user(conn, user, otp_app: :food_delivery)
      restaurant = Repo.get_by(Restaurant, name: "some restaurant name")

      conn =
        put(conn, Routes.restaurant_meal_path(conn, :update, restaurant.id, meal),
          meal: @update_meal_attrs
        )

      assert %{
               "active" => true,
               "description" => "some updated description",
               "img_url" => "",
               "price" => 43
             } = json_response(conn, 200)["data"]

      # conn = get(conn, Routes.restaurant_meal_path(conn, :show, restaurant.id, id))

      assert %{
               "id" => id,
               "active" => true,
               "description" => "some updated description",
               "name" => "some updated name",
               "price" => 43
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, meal: meal} do
      user = Repo.get_by(User, email: "owner@example.com")
      conn = Pow.Plug.assign_current_user(conn, user, otp_app: :food_delivery)
      restaurant = Repo.get_by(Restaurant, name: "some restaurant name")

      conn =
        put(conn, Routes.restaurant_meal_path(conn, :update, restaurant.id, meal),
          meal: @invalid_meal_attrs
        )

      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete meal" do
    setup [:create_meal]

    test "deletes chosen meal", %{conn: conn, meal: meal} do
      user = Repo.get_by(User, email: "owner@example.com")
      conn = Pow.Plug.assign_current_user(conn, user, otp_app: :food_delivery)
      restaurant = Repo.get_by(Restaurant, name: "some restaurant name")

      conn = delete(conn, Routes.restaurant_meal_path(conn, :delete, restaurant.id, meal))
      assert response(conn, 204)
    end
  end

  defp create_meal(_) do
    meal = fixture(:meal)
    {:ok, meal: meal}
  end
end
