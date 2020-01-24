defmodule FoodDeliveryWeb.RestaurantControllerUserTest do
  use FoodDeliveryWeb.ConnCase

  alias FoodDelivery.Menu
  alias FoodDelivery.Menu.Restaurant

  @create_attrs %{
    description: "some description",
    name: "some name",
    img_url: "some img_url",
    owner_id: 1
  }
  @update_attrs %{
    description: "some updated description",
    name: "some updated name",
    img_url: "some updated img_url"
  }
  @invalid_attrs %{description: nil, name: nil}

  def fixture(:restaurant) do
    {:ok, user} =
      Pow.Ecto.Context.create(
        %{email: "owner@example.com", password: "password", confirm_password: "password"},
        otp_app: :food_delivery
      )

    {:ok, restaurant} = Menu.create_restaurant(%{@create_attrs | owner_id: user.id})
    restaurant
  end

  setup %{conn: conn} do
    user = %FoodDelivery.Users.User{email: "user@example.com", role: "user"}
    conn = Pow.Plug.assign_current_user(conn, user, otp_app: :food_delivery)

    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all restaurants (for user)", %{conn: conn} do
      conn = get(conn, Routes.restaurant_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create restaurant" do
    test "forbidden for create restaurant (for user)", %{conn: conn} do
      conn = post(conn, Routes.restaurant_path(conn, :create), restaurant: @create_attrs)
      assert json_response(conn, 403)["errors"] == %{"detail" => "Forbidden"}
    end
  end

  describe "update restaurant" do
    setup [:create_restaurant]

    test "forbidden for update restaurant (for user)", %{
      conn: conn,
      restaurant: %Restaurant{id: id} = restaurant
    } do
      conn =
        put(conn, Routes.restaurant_path(conn, :update, restaurant), restaurant: @update_attrs)

      assert json_response(conn, 403)["errors"] == %{"detail" => "Forbidden"}
    end
  end

  describe "delete restaurant (for user)" do
    setup [:create_restaurant]

    test "forbidden for delete restaurant", %{conn: conn, restaurant: restaurant} do
      conn = delete(conn, Routes.restaurant_path(conn, :delete, restaurant))
      assert json_response(conn, 403)["errors"] == %{"detail" => "Forbidden"}
    end
  end

  defp create_restaurant(_) do
    restaurant = fixture(:restaurant)
    {:ok, restaurant: restaurant}
  end
end
