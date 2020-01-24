defmodule FoodDeliveryWeb.OrderControllerTest do
  use FoodDeliveryWeb.ConnCase

  alias FoodDelivery.Menu
  alias FoodDelivery.Menu.Meal
  alias FoodDelivery.Cart
  alias FoodDelivery.Cart.Order
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
    description: "some meal description",
    name: "some meal name",
    price: 42,
    restaurant_id: nil
  }

  @create_order_attrs %{
    "meal_id" => nil,
    "qty" => 1
  }
  @update_order_attrs %{
    "meal_id" => nil,
    "qty" => 2
  }
  # @invalid_order_attrs %{"meal_id" => nil, "qty" => nil}

  def fixture(:order) do
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

    {:ok, user} =
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

    {:ok, order} =
      Cart.create_or_update_meal_order(%{@create_order_attrs | "meal_id" => meal.id}, user)

    order
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    setup [:create_order]

    test "lists all orders", %{conn: conn} do
      user = Repo.get_by(User, email: "user@example.com")
      conn = Pow.Plug.assign_current_user(conn, user, otp_app: :food_delivery)

      conn = get(conn, Routes.order_path(conn, :index))

      assert [
               %{
                 "canceled_date" => nil,
                 "delivered_date" => nil,
                 "in_route_date" => nil,
                 "orders_meals" => [
                   %{
                     "meal" => %{
                       "active" => true,
                       "description" => "some meal description",
                       "img_url" => "",
                       "name" => "some meal name",
                       "price" => 42
                     },
                     "qty" => 1
                   }
                 ],
                 "placed_date" => nil,
                 "processing_date" => nil,
                 "received_date" => nil,
                 "status" => "not_placed"
               }
             ] = json_response(conn, 200)["data"]
    end
  end

  describe "create order" do
    setup [:create_order]

    test "renders order when data is valid", %{conn: conn} do
      user = Repo.get_by(User, email: "user@example.com")
      conn = Pow.Plug.assign_current_user(conn, user, otp_app: :food_delivery)

      meal = Repo.get_by(Meal, name: "some meal name")

      conn =
        post(conn, Routes.order_path(conn, :create),
          order_meal: %{@create_order_attrs | "meal_id" => meal.id}
        )

      assert %{
               "canceled_date" => nil,
               "delivered_date" => nil,
               "id" => id,
               "in_route_date" => nil,
               "placed_date" => nil,
               "processing_date" => nil,
               "received_date" => nil,
               "status" => "not_placed"
             } = json_response(conn, 200)["data"]

      # conn = get(conn, Routes.order_path(conn, :show, id))

      # assert %{
      #          "id" => id,
      #          "date" => "2010-04-17T14:00:00Z",
      #          "status" => "some status"
      #        } = json_response(conn, 200)["data"]
    end
  end

  describe "update order" do
    setup [:create_order]

    test "renders order when data is valid", %{
      conn: conn,
      order: %{updated_order: %Order{id: id}}
    } do
      user = Repo.get_by(User, email: "user@example.com")
      conn = Pow.Plug.assign_current_user(conn, user, otp_app: :food_delivery)
      meal = Repo.get_by(Meal, name: "some meal name")

      conn =
        post(conn, Routes.order_path(conn, :create),
          order_meal: %{@update_order_attrs | "meal_id" => meal.id}
        )

      assert %{
               "id" => ^id,
               "canceled_date" => nil,
               "delivered_date" => nil,
               "in_route_date" => nil,
               "placed_date" => nil,
               "processing_date" => nil,
               "received_date" => nil,
               "status" => "not_placed"
             } = json_response(conn, 200)["data"]
    end
  end

  describe "delete order" do
    setup [:create_order]

    test "deletes chosen order", %{conn: conn, order: %{updated_order: %Order{} = order}} do
      user = Repo.get_by(User, email: "user@example.com")
      conn = Pow.Plug.assign_current_user(conn, user, otp_app: :food_delivery)

      conn = delete(conn, Routes.order_path(conn, :delete, order))
      assert response(conn, 204)
    end
  end

  defp create_order(_) do
    order = fixture(:order)
    {:ok, order: order}
  end
end
