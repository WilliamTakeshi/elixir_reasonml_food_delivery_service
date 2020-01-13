defmodule FoodDelivery.MenuTest do
  use FoodDelivery.DataCase

  alias FoodDelivery.Menu

  describe "restaurants" do
    alias FoodDelivery.Menu.Restaurant

    @valid_attrs %{description: "some description", name: "some name"}
    @update_attrs %{description: "some updated description", name: "some updated name"}
    @invalid_attrs %{description: nil, name: nil}

    def restaurant_fixture(attrs \\ %{}) do
      {:ok, restaurant} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Menu.create_restaurant()

      restaurant
    end

    test "list_restaurants/0 returns all restaurants" do
      restaurant = restaurant_fixture()
      assert Menu.list_restaurants() == [restaurant]
    end

    test "get_restaurant!/1 returns the restaurant with given id" do
      restaurant = restaurant_fixture()
      assert Menu.get_restaurant!(restaurant.id) == restaurant
    end

    test "create_restaurant/1 with valid data creates a restaurant" do
      assert {:ok, %Restaurant{} = restaurant} = Menu.create_restaurant(@valid_attrs)
      assert restaurant.description == "some description"
      assert restaurant.name == "some name"
    end

    test "create_restaurant/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Menu.create_restaurant(@invalid_attrs)
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
      assert restaurant == Menu.get_restaurant!(restaurant.id)
    end

    test "delete_restaurant/1 deletes the restaurant" do
      restaurant = restaurant_fixture()
      assert {:ok, %Restaurant{}} = Menu.delete_restaurant(restaurant)
      assert_raise Ecto.NoResultsError, fn -> Menu.get_restaurant!(restaurant.id) end
    end

    test "change_restaurant/1 returns a restaurant changeset" do
      restaurant = restaurant_fixture()
      assert %Ecto.Changeset{} = Menu.change_restaurant(restaurant)
    end
  end

  describe "meals" do
    alias FoodDelivery.Menu.Meal

    @valid_attrs %{active: true, description: "some description", name: "some name", price: 42}
    @update_attrs %{
      active: false,
      description: "some updated description",
      name: "some updated name",
      price: 43
    }
    @invalid_attrs %{active: nil, description: nil, name: nil, price: nil}

    def meal_fixture(attrs \\ %{}) do
      {:ok, meal} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Menu.create_meal()

      meal
    end

    test "list_meals/0 returns all meals" do
      meal = meal_fixture()
      assert Menu.list_meals() == [meal]
    end

    test "get_meal!/1 returns the meal with given id" do
      meal = meal_fixture()
      assert Menu.get_meal!(meal.id) == meal
    end

    test "create_meal/1 with valid data creates a meal" do
      assert {:ok, %Meal{} = meal} = Menu.create_meal(@valid_attrs)
      assert meal.active == true
      assert meal.description == "some description"
      assert meal.name == "some name"
      assert meal.price == 42
    end

    test "create_meal/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Menu.create_meal(@invalid_attrs)
    end

    test "update_meal/2 with valid data updates the meal" do
      meal = meal_fixture()
      assert {:ok, %Meal{} = meal} = Menu.update_meal(meal, @update_attrs)
      assert meal.active == false
      assert meal.description == "some updated description"
      assert meal.name == "some updated name"
      assert meal.price == 43
    end

    test "update_meal/2 with invalid data returns error changeset" do
      meal = meal_fixture()
      assert {:error, %Ecto.Changeset{}} = Menu.update_meal(meal, @invalid_attrs)
      assert meal == Menu.get_meal!(meal.id)
    end

    test "delete_meal/1 deletes the meal" do
      meal = meal_fixture()
      assert {:ok, %Meal{}} = Menu.delete_meal(meal)
      assert_raise Ecto.NoResultsError, fn -> Menu.get_meal!(meal.id) end
    end

    test "change_meal/1 returns a meal changeset" do
      meal = meal_fixture()
      assert %Ecto.Changeset{} = Menu.change_meal(meal)
    end
  end
end
