defmodule FoodDelivery.Menu do
  @moduledoc """
  The Menu context.
  """

  import Ecto.Query, warn: false
  alias FoodDelivery.Repo

  alias FoodDelivery.Menu.Restaurant
  alias FoodDelivery.Menu.Meal

  @doc """
  Returns the list of restaurants.

  ## Examples

      iex> list_restaurants()
      [%Restaurant{}, ...]

  """
  def list_restaurants do
    Repo.all(Restaurant)
  end

  @doc """
  Gets a single restaurant.

  Raises `Ecto.NoResultsError` if the Restaurant does not exist.

  ## Examples

      iex> get_restaurant!(123)
      %Restaurant{}

      iex> get_restaurant!(456)
      ** (Ecto.NoResultsError)

  """
  def get_restaurant!(id), do: Repo.get!(Restaurant, id)

  @doc """
  Creates a restaurant.

  ## Examples

      iex> create_restaurant(%{field: value})
      {:ok, %Restaurant{}}

      iex> create_restaurant(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_restaurant(attrs \\ %{}) do
    %Restaurant{}
    |> Restaurant.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a restaurant.

  ## Examples

      iex> update_restaurant(restaurant, %{field: new_value})
      {:ok, %Restaurant{}}

      iex> update_restaurant(restaurant, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_restaurant(%Restaurant{} = restaurant, attrs) do
    restaurant
    |> Restaurant.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Restaurant.

  ## Examples

      iex> delete_restaurant(restaurant)
      {:ok, %Restaurant{}}

      iex> delete_restaurant(restaurant)
      {:error, %Ecto.Changeset{}}

  """
  def delete_restaurant(%Restaurant{} = restaurant) do
    Repo.delete(restaurant)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking restaurant changes.

  ## Examples

      iex> change_restaurant(restaurant)
      %Ecto.Changeset{source: %Restaurant{}}

  """
  def change_restaurant(%Restaurant{} = restaurant) do
    Restaurant.changeset(restaurant, %{})
  end

  @doc """
  Returns the list of meals.

  ## Examples

      iex> list_meals()
      [%Meal{}, ...]

  """
  def list_meals do
    Repo.all(Meal)
  end

  @doc """
  Gets a single meal.

  Raises `Ecto.NoResultsError` if the Meal does not exist.

  ## Examples

      iex> get_meal!(123)
      %Meal{}

      iex> get_meal!(456)
      ** (Ecto.NoResultsError)

  """
  def get_meal!(id), do: Repo.get!(Meal, id)

  @doc """
  Creates a meal.

  ## Examples

      iex> create_meal(%{field: value})
      {:ok, %Meal{}}

      iex> create_meal(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_meal(attrs \\ %{}) do
    %Meal{}
    |> Meal.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a meal.

  ## Examples

      iex> update_meal(meal, %{field: new_value})
      {:ok, %Meal{}}

      iex> update_meal(meal, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_meal(%Meal{} = meal, attrs) do
    meal
    |> Meal.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Meal.

  ## Examples

      iex> delete_meal(meal)
      {:ok, %Meal{}}

      iex> delete_meal(meal)
      {:error, %Ecto.Changeset{}}

  """
  def delete_meal(%Meal{} = meal) do
    Repo.delete(meal)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking meal changes.

  ## Examples

      iex> change_meal(meal)
      %Ecto.Changeset{source: %Meal{}}

  """
  def change_meal(%Meal{} = meal) do
    Meal.changeset(meal, %{})
  end
end
