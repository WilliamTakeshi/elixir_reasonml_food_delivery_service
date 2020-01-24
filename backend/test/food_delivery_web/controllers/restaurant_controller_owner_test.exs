defmodule FoodDeliveryWeb.RestaurantControllerOwnerTest do
  use FoodDeliveryWeb.ConnCase

  alias FoodDelivery.Menu
  alias FoodDelivery.Menu.Restaurant
  alias FoodDelivery.Repo
  alias FoodDelivery.Users.User

  @create_attrs %{
    description: "some description",
    name: "some name",
    img_url: "some img_url",
    owner_id: nil
  }
  @update_attrs %{
    description: "some updated description",
    name: "some updated name",
    img_url: "some updated img_url"
  }
  @invalid_attrs %{description: nil, name: nil}

  def fixture(:restaurant_and_user) do
    {:ok, user} =
      Pow.Ecto.Context.create(
        %{email: "owner@example.com", password: "password", confirm_password: "password"},
        otp_app: :food_delivery
      )

    {:ok, restaurant} = Menu.create_restaurant(%{@create_attrs | owner_id: user.id})
    %{restaurant: restaurant, user: user}
  end

  def fixture(:user) do
    {:ok, user} =
      Pow.Ecto.Context.create(
        %{email: "owner@example.com", password: "password", confirm_password: "password"},
        otp_app: :food_delivery
      )

    user
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    setup [:create_user]

    test "lists all restaurants (for owner)", %{conn: conn} do
      user = Repo.get_by(User, email: "owner@example.com")
      conn = Pow.Plug.assign_current_user(conn, user, otp_app: :food_delivery)

      conn = get(conn, Routes.restaurant_path(conn, :index))

      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create restaurant" do
    setup [:create_user]

    test "forbidden for create restaurant (for owner)", %{conn: conn} do
      user = Repo.get_by(User, email: "owner@example.com")
      conn = Pow.Plug.assign_current_user(conn, user, otp_app: :food_delivery)

      conn = post(conn, Routes.restaurant_path(conn, :create), restaurant: @create_attrs)
      assert json_response(conn, 403)["errors"] == %{"detail" => "Forbidden"}
    end
  end

  describe "update restaurant" do
    setup [:create_restaurant_and_user]

    test "renders restaurant when data is valid (for owner)", %{
      conn: conn,
      restaurant: %Restaurant{} = restaurant
    } do
      user = Repo.get_by(User, email: "owner@example.com")
      conn = Pow.Plug.assign_current_user(conn, user, otp_app: :food_delivery)

      conn =
        put(conn, Routes.restaurant_path(conn, :update, restaurant), restaurant: @update_attrs)

      assert %{
               "description" => "some updated description",
               "img_url" => "some updated img_url",
               "name" => "some updated name"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, restaurant: restaurant} do
      user = Repo.get_by(User, email: "owner@example.com")
      conn = Pow.Plug.assign_current_user(conn, user, otp_app: :food_delivery)

      conn =
        put(conn, Routes.restaurant_path(conn, :update, restaurant), restaurant: @invalid_attrs)

      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete restaurant (for owner)" do
    setup [:create_restaurant_and_user]

    test "forbidden for delete restaurant", %{conn: conn, restaurant: restaurant} do
      user = Repo.get_by(User, email: "owner@example.com")
      conn = Pow.Plug.assign_current_user(conn, user, otp_app: :food_delivery)

      conn = delete(conn, Routes.restaurant_path(conn, :delete, restaurant))
      assert json_response(conn, 403)["errors"] == %{"detail" => "Forbidden"}
    end
  end

  defp create_restaurant_and_user(_) do
    %{restaurant: restaurant, user: user} = fixture(:restaurant_and_user)
    {:ok, restaurant: restaurant}
  end

  defp create_user(_) do
    user = fixture(:user)
    {:ok, user: user}
  end
end
