defmodule FoodDelivery.Cart do
  @moduledoc """
  The Cart context.
  """

  import Ecto.Query, warn: false
  alias FoodDelivery.Repo
  alias FoodDelivery.Users.User

  alias FoodDelivery.Cart.{
    Order,
    OrderMeal
  }

  @doc """
  Returns the list of user orders.
  """
  def list_orders(%User{role: "user"} = user) do
    Repo.all(
      from(o in Order,
        preload: [orders_meals: :meal],
        where: o.user_id == ^user.id,
        order_by: [o.id]
      )
    )
  end

  @doc """
  Returns the list of restaurant orders.
  """
  def list_orders(%User{role: "owner"} = user) do
    Repo.all(
      from(o in Order,
        join: r in assoc(o, :restaurant),
        preload: [orders_meals: :meal],
        where: r.owner_id == ^user.id or o.user_id == ^user.id,
        order_by: [o.id]
      )
    )
  end

  @doc """
  Gets a single order.

  Returns {:error, :not_found} if the Order does not exist.

  ## Examples

      iex> get_order!(123)
      %Order{}

      iex> get_order!(456)
      {:error, :not_found}

  """
  def get_order(id) do
    case Repo.one(
           from(o in Order,
             preload: [:restaurant, orders_meals: :meal],
             where: o.id == ^id
           )
         ) do
      nil -> {:error, :not_found}
      order -> {:ok, order}
    end
  end

  @doc """
  Creates a order.

  ## Examples

      iex> create_or_update_meal_order(%{field: value})
      {:ok, %Order{}}

      iex> create_or_update_meal_order(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_or_update_meal_order(%{"meal_id" => meal_id, "qty" => qty}, %User{} = user) do
    meal = Repo.get!(FoodDelivery.Menu.Meal, meal_id)

    Ecto.Multi.new()
    |> Ecto.Multi.run(:order, fn repo, _changes ->
      {:ok,
       repo.one(
         from(
           o in Order,
           where:
             o.restaurant_id == ^meal.restaurant_id and o.user_id == ^user.id and
               o.status == ^"not_placed"
         )
       ) || %Order{}}
    end)
    |> Ecto.Multi.insert_or_update(:updated_order, fn %{order: order} ->
      Ecto.Changeset.change(order, %{restaurant_id: meal.restaurant_id, user_id: user.id})
    end)
    |> Ecto.Multi.run(:order_meal, fn repo, %{updated_order: updated_order} ->
      {:ok,
       repo.one(
         from(
           om in OrderMeal,
           where: om.meal_id == ^meal_id and om.order_id == ^updated_order.id
         )
       ) || Ecto.build_assoc(updated_order, :orders_meals)}
    end)
    |> Ecto.Multi.insert_or_update(:updated_order_meal, fn %{order_meal: order_meal} ->
      OrderMeal.changeset(order_meal, %{meal_id: meal_id, qty: qty + (order_meal.qty || 0)})
    end)
    |> Repo.transaction()
  end

  @doc """
  Updates a order.

  ## Examples

      iex> update_order(order, %{field: new_value})
      {:ok, %Order{}}

      iex> update_order(order, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_order(%Order{} = order, attrs) do
    order
    |> Order.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Order.

  ## Examples

      iex> delete_order(order)
      {:ok, %Order{}}

      iex> delete_order(order)
      {:error, %Ecto.Changeset{}}

  """
  def delete_order(%Order{} = order) do
    Repo.delete(order)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking order changes.

  ## Examples

      iex> change_order(order)
      %Ecto.Changeset{source: %Order{}}

  """
  def change_order(%Order{} = order) do
    Order.changeset(order, %{})
  end

  @doc """
  Updates an order status.

  ## Examples

      iex> change_status(order)
      {:ok, %Order{}}

  """
  def change_status(%Order{} = order, status) do
    order
    |> Order.change_status(status)
    |> Repo.update()
  end
end
