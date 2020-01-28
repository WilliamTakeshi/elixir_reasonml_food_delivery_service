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
  def list_restaurants(user) do
    blocked_restaurant_ids =
      Repo.all(
        from(b in FoodDelivery.Permission.Block,
          where: b.user_id == ^user.id,
          select: b.restaurant_id,
          order_by: [b.id]
        )
      )

    Repo.all(
      from(r in Restaurant,
        where: not (r.id in ^blocked_restaurant_ids),
        order_by: [r.id]
      )
    )
  end

  @doc """
  Gets a single restaurant with meals.

  Raises `Ecto.NoResultsError` if the Restaurant does not exist.

  ## Examples

      iex> get_restaurant!(123)
      %Restaurant{}

      iex> get_restaurant!(456)
      ** (Ecto.NoResultsError)

  """
  def get_restaurant_with_meals(id, user) do
    blocked_restaurant_ids =
      Repo.all(
        from(b in FoodDelivery.Permission.Block,
          where: b.user_id == ^user.id,
          select: b.restaurant_id
        )
      )

    meals_query = from(m in Meal, where: m.active == true)

    Repo.all(
      from(
        r in Restaurant,
        preload: [meals: ^meals_query],
        where: r.id == ^id,
        where: not (r.id in ^blocked_restaurant_ids)
      )
    )
  end

  @doc """
  Gets a single restaurant.

  Returns {:error, :not_found} if the Restaurant does not exist.

  ## Examples

      iex> get_restaurant!(123)
      %Restaurant{}

      iex> get_restaurant!(456)
      {:error, :not_found}

  """
  def get_restaurant(id) do
    case Repo.get(Restaurant, id) do
      nil -> {:error, :not_found}
      restaurant -> {:ok, restaurant}
    end
  end

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
    |> Restaurant.update_changeset(attrs)
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
    Repo.all(
      from(m in Meal,
        where: m.active == true,
        order_by: [m.name, m.id]
      )
    )
  end

  @doc """
  Gets a single meal.

  Return {:error, :not_found} if the Meal does not exist.

  ## Examples

      iex> get_meal!(123)
      %Meal{}

      iex> get_meal!(456)
      ** (Ecto.NoResultsError)

  """
  def get_meal(id, restaurant_id) do
    meal =
      Repo.one(
        from(m in Meal,
          join: r in assoc(m, :restaurant),
          where: m.id == ^id,
          where: r.id == ^restaurant_id,
          where: m.active == true
        )
      )

    case meal do
      nil -> {:error, :not_found}
      meal -> {:ok, meal}
    end
  end

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
    deactivate_meal(meal)

    attrs =
      attrs
      |> Enum.into(Map.from_struct(meal))

    attrs =
      for {key, val} <- attrs, into: %{} do
        cond do
          is_atom(key) -> {Atom.to_string(key), val}
          true -> {key, val}
        end
      end

    create_meal(attrs)
  end

  @doc """
  Deletes a Meal.

  ## Examples

      iex> deactivate_meal(meal)
      {:ok, %Meal{}}

      iex> deactivate_meal(meal)
      {:error, %Ecto.Changeset{}}

  """
  def deactivate_meal(%Meal{} = meal) do
    meal
    |> Meal.changeset(%{active: false})
    |> Repo.update()
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
