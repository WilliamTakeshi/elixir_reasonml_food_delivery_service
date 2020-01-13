defmodule FoodDelivery.CartTest do
  use FoodDelivery.DataCase

  alias FoodDelivery.Cart

  describe "orders" do
    alias FoodDelivery.Cart.Order

    @valid_attrs %{date: "2010-04-17T14:00:00Z", status: "some status"}
    @update_attrs %{date: "2011-05-18T15:01:01Z", status: "some updated status"}
    @invalid_attrs %{date: nil, status: nil}

    def order_fixture(attrs \\ %{}) do
      {:ok, order} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Cart.create_order()

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

    test "create_order/1 with valid data creates a order" do
      assert {:ok, %Order{} = order} = Cart.create_order(@valid_attrs)
      assert order.date == DateTime.from_naive!(~N[2010-04-17T14:00:00Z], "Etc/UTC")
      assert order.status == "some status"
    end

    test "create_order/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Cart.create_order(@invalid_attrs)
    end

    test "update_order/2 with valid data updates the order" do
      order = order_fixture()
      assert {:ok, %Order{} = order} = Cart.update_order(order, @update_attrs)
      assert order.date == DateTime.from_naive!(~N[2011-05-18T15:01:01Z], "Etc/UTC")
      assert order.status == "some updated status"
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
