defmodule FoodDelivery.Policy do
  @behaviour Bodyguard.Policy

  alias FoodDelivery.Users.User

  # Admin users can do anything
  def authorize(_, %User{role: "admin"}, _), do: :ok

  # ---------------- Order controller ----------------

  # Users can see they own orders
  # Owners can see restaurant orders
  def authorize(:show_order, user, order) do
    cond do
      user.id == order.user_id -> :ok
      user.role == "owner" and user.id == order.restaurant.owner_id -> :ok
      true -> :error
    end
  end

  # Users can delete they own orders if not_placed
  def authorize(:delete_order, user, order) do
    cond do
      user.id == order.user_id and order.status == "not_placed" -> :ok
      true -> :error
    end
  end

  # Users can change some status
  # Restaurant owners can change some other status
  def authorize(:change_status_order, user, %{order: order, new_status: new_status}) do
    cond do
      user.id == order.user_id and
          MapSet.member?(MapSet.new(["placed", "canceled", "received"]), new_status) ->
        :ok

      user.role == "owner" and user.id == order.restaurant.owner_id and
          MapSet.member?(MapSet.new(["processing", "in_route", "delivered"]), new_status) ->
        :ok

      true ->
        :error
    end
  end

  # ---------------- Restaurant Controller ----------------

  # Only admin can create restaurants
  def authorize(:create_restaurant, _, _), do: :error

  # Only admin can create restaurants
  def authorize(:delete_restaurant, _, _), do: :error

  # Restaurant owner can update own restaurant
  def authorize(:update_restaurant, user, restaurant) do
    cond do
      user.id == restaurant.owner_id -> :ok
      true -> :error
    end
  end

  # ---------------- Meal Controller ----------------
  # Restaurant owner can create meals
  def authorize(:create_meal, user, restaurant) do
    cond do
      user.id == restaurant.owner_id -> :ok
      true -> :error
    end
  end

  # Restaurant update can create meals
  def authorize(:update_meal, user, restaurant) do
    cond do
      user.id == restaurant.owner_id -> :ok
      true -> :error
    end
  end

  # Restaurant delete can create meals
  def authorize(:delete_meal, user, restaurant) do
    cond do
      user.id == restaurant.owner_id -> :ok
      true -> :error
    end
  end

  # --------------------------------------------
  # Catch-all: deny everything else
  def authorize(_, _, _), do: :error
end
