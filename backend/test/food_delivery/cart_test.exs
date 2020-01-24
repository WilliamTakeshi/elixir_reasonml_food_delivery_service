defmodule FoodDelivery.CartTest do
  use FoodDelivery.DataCase

  alias FoodDelivery.Cart

  describe "orders" do
    alias FoodDelivery.Cart.Order

    @valid_attrs %{"meal_id" => 1, "qty" => 1}
    @update_attrs %{"meal_id" => 1, "qty" => 2}
    @invalid_attrs %{"meal_id" => nil, "qty" => nil}

    def order_fixture(attrs \\ %{}) do
      {:ok, order} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Cart.create_or_update_meal_order()

      order
    end

    test "list_orders/0 returns all orders" do
      order = order_fixture()
      assert Cart.list_orders() == [order]
    end

    test "get_order!/1 returns the order with given id" do
      order = order_fixture()
      assert Cart.get_order!(order.id) == order
    end

    test "create_or_update_meal_order/1 with valid data creates a order" do
      assert {:ok, %Order{} = order} = Cart.create_or_update_meal_order(@valid_attrs)
      assert order.meal_id == 1
      assert order.qty == 1
    end

    test "create_or_update_meal_order/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Cart.create_or_update_meal_order(@invalid_attrs)
    end

    test "update_order/2 with valid data updates the order" do
      order = order_fixture()
      assert {:ok, %Order{} = order} = Cart.update_order(order, @update_attrs)
      assert order.meal_id == 1
      assert order.qty == 3
    end

    test "update_order/2 with invalid data returns error changeset" do
      order = order_fixture()
      assert {:error, %Ecto.Changeset{}} = Cart.update_order(order, @invalid_attrs)
      assert order == Cart.get_order!(order.id)
    end

    test "delete_order/1 deletes the order" do
      order = order_fixture()
      assert {:ok, %Order{}} = Cart.delete_order(order)
      assert_raise Ecto.NoResultsError, fn -> Cart.get_order!(order.id) end
    end

    test "change_order/1 returns a order changeset" do
      order = order_fixture()
      assert %Ecto.Changeset{} = Cart.change_order(order)
    end
  end
end
