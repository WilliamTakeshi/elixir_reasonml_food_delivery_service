defmodule FoodDelivery.MenuTest do
  use FoodDelivery.DataCase

  alias FoodDelivery.Menu

  describe "restaurants" do
    alias FoodDelivery.Menu.Restaurant

    @valid_attrs %{
      description: "some description",
      name: "some name",
      img_url: "some img",
      owner_id: nil
    }
    @update_attrs %{
      description: "some updated description",
      name: "some updated name",
      img_url: "some updated img"
    }
    @invalid_attrs %{description: nil, name: nil, owner_id: nil}

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
        |> Enum.into(%{@valid_attrs | owner_id: owner.id})
        |> Menu.create_restaurant()

      restaurant
    end

    test "get_restaurant!/1 returns the restaurant with given id" do
      restaurant = restaurant_fixture()
      {:ok, get_rest} = Menu.get_restaurant(restaurant.id)
      assert get_rest == restaurant
    end

    test "create_restaurant/1 with valid data creates a restaurant" do
      owner = owner_fixture()

      assert {:ok, %Restaurant{} = restaurant} =
               Menu.create_restaurant(%{@valid_attrs | owner_id: owner.id})

      assert restaurant.description == "some description"
      assert restaurant.name == "some name"
    end

    test "create_restaurant/1 with invalid data returns error changeset" do
      owner = owner_fixture()

      assert {:error, %Ecto.Changeset{}} =
               Menu.create_restaurant(%{@invalid_attrs | owner_id: owner.id})
    end

    test "update_restaurant/2 with valid data updates the restaurant" do
      restaurant = restaurant_fixture()
      assert {:ok, %Restaurant{} = restaurant} = Menu.update_restaurant(restaurant, @update_attrs)
      assert restaurant.description == "some updated description"
      assert restaurant.name == "some updated name"
    end

    test "update_restaurant/2 with invalid data returns error changeset" do
      restaurant = restaurant_fixture()
      assert {:error, %Ecto.Changeset{}} = Menu.update_restaurant(restaurant, @invalid_attrs)
      {:ok, get_rest} = Menu.get_restaurant(restaurant.id)
      assert restaurant == get_rest
    end

    test "delete_restaurant/1 deletes the restaurant" do
      restaurant = restaurant_fixture()
      assert {:ok, %Restaurant{}} = Menu.delete_restaurant(restaurant)
      assert {:error, :not_found} = Menu.get_restaurant(restaurant.id)
    end

    test "change_restaurant/1 returns a restaurant changeset" do
      restaurant = restaurant_fixture()
      assert %Ecto.Changeset{} = Menu.change_restaurant(restaurant)
    end
  end

  describe "meals" do
    alias FoodDelivery.Menu.Meal

    @valid_attrs %{
      active: true,
      description: "some description",
      name: "some name",
      price: 42,
      restaurant_id: nil
    }
    @update_attrs %{
      active: true,
      description: "some updated description",
      name: "some updated name",
      price: 43
    }
    @invalid_attrs %{active: nil, description: nil, name: nil, price: nil, restaurant_id: nil}

    def meal_fixture(attrs \\ %{}) do
      restaurant = restaurant_fixture()

      {:ok, meal} =
        attrs
        |> Enum.into(%{@valid_attrs | restaurant_id: restaurant.id})
        |> Menu.create_meal()

      {meal, restaurant}
    end

    test "list_meals/0 returns all meals" do
      {meal, _restaurant} = meal_fixture()
      assert Menu.list_meals() == [meal]
    end

    test "get_meal/1 returns the meal with given id" do
      {meal, restaurant} = meal_fixture()
      assert Menu.get_meal(meal.id, restaurant.id) == {:ok, meal}
    end

    test "create_meal/1 with valid data creates a meal" do
      {_meal, restaurant} = meal_fixture()

      assert {:ok, %Meal{} = meal} =
               Menu.create_meal(%{@valid_attrs | restaurant_id: restaurant.id})

      assert meal.active == true
      assert meal.description == "some description"
      assert meal.name == "some name"
      assert meal.price == 42
      assert meal.restaurant_id == restaurant.id
    end

    test "create_meal/1 with invalid data returns error changeset" do
      {_meal, restaurant} = meal_fixture()

      assert {:error, %Ecto.Changeset{}} =
               Menu.create_meal(%{@invalid_attrs | restaurant_id: restaurant.id})
    end

    test "update_meal/2 with valid data creates a new meal" do
      {meal, _restaurant} = meal_fixture()
      assert {:ok, %Meal{} = meal} = Menu.update_meal(meal, @update_attrs)
      assert meal.active == true
      assert meal.description == "some updated description"
      assert meal.name == "some updated name"
      assert meal.price == 43
    end

    test "deactivate_meal/1 deletes the meal" do
      {meal, restaurant} = meal_fixture()
      assert {:ok, %Meal{}} = Menu.deactivate_meal(meal)
      assert {:error, :not_found} = Menu.get_meal(meal.id, restaurant.id)
    end

    test "change_meal/1 returns a meal changeset" do
      {meal, _restaurant} = meal_fixture()
      assert %Ecto.Changeset{} = Menu.change_meal(meal)
    end
  end
end
