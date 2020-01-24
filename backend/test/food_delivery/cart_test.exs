defmodule FoodDelivery.CartTest do
  use FoodDelivery.DataCase

  alias FoodDelivery.Cart
  alias FoodDelivery.Menu

  describe "orders" do
    alias FoodDelivery.Cart.Order

    @valid_rest_attrs %{description: "some description", name: "some name", owner_id: nil}

    @valid_meal_attrs %{
      active: true,
      description: "some description",
      name: "some name",
      price: 42,
      restaurant_id: nil
    }

    @valid_attrs %{"meal_id" => nil, "qty" => 1}
    @update_attrs %{"meal_id" => nil, "qty" => 2}
    # @invalid_attrs %{"meal_id" => nil, "qty" => nil}

    def user_fixture() do
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

      user
    end

    def owner_fixture() do
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

      owner
    end

    def restaurant_fixture(attrs \\ %{}) do
      owner = owner_fixture()

      {:ok, restaurant} =
        attrs
        |> Enum.into(%{@valid_rest_attrs | owner_id: owner.id})
        |> Menu.create_restaurant()

      restaurant
    end

    def meal_fixture(attrs \\ %{}) do
      restaurant = restaurant_fixture()

      {:ok, meal} =
        attrs
        |> Enum.into(%{@valid_meal_attrs | restaurant_id: restaurant.id})
        |> Menu.create_meal()

      {meal, restaurant}
    end

    def order_fixture(attrs \\ %{}) do
      {meal, restaurant} = meal_fixture()
      user = user_fixture()

      {:ok, %{updated_order: order}} =
        attrs
        |> Enum.into(%{@valid_attrs | "meal_id" => meal.id})
        |> Cart.create_or_update_meal_order(user)

      %{order: order, meal: meal, restaurant: restaurant, user: user}
    end

    test "list_orders/0 returns all orders" do
      %{order: order, user: user} = order_fixture()
      [get_order] = Cart.list_orders(user)

      assert get_order.canceled_date == order.canceled_date
      assert get_order.delivered_date == order.delivered_date
      assert get_order.id == order.id
      assert get_order.inserted_at == order.inserted_at
      assert get_order.placed_date == order.placed_date
      assert get_order.processing_date == order.processing_date
      assert get_order.received_date == order.received_date
      assert get_order.restaurant_id == order.restaurant_id
      assert get_order.status == order.status
      assert get_order.updated_at == order.updated_at
      assert get_order.user_id == order.user_id
    end

    test "get_order!/1 returns the order with given id" do
      %{order: order} = order_fixture()
      assert {:ok, _} = Cart.get_order(order.id)
    end

    test "create_or_update_meal_order/1 with valid data creates a order" do
      %{user: user, meal: meal, restaurant: restaurant} = order_fixture()

      {:ok, %{updated_order: %Order{} = order}} =
        Cart.create_or_update_meal_order(%{@valid_attrs | "meal_id" => meal.id}, user)

      assert order.user_id == user.id
      assert order.restaurant_id == restaurant.id
    end

    test "update_order/2 with valid data updates the order" do
      %{user: user, restaurant: restaurant, order: order} = order_fixture()
      assert {:ok, %Order{} = order} = Cart.update_order(order, @update_attrs)

      assert order.user_id == user.id
      assert order.restaurant_id == restaurant.id
    end

    test "delete_order/1 deletes the order" do
      %{order: order} = order_fixture()
      assert {:ok, %Order{}} = Cart.delete_order(order)
      assert {:error, :not_found} = Cart.get_order(order.id)
    end

    test "change_order/1 returns a order changeset" do
      %{order: order} = order_fixture()
      assert %Ecto.Changeset{} = Cart.change_order(order)
    end
  end
end
