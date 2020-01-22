defmodule FoodDeliveryWeb.OrderController do
  use FoodDeliveryWeb, :controller

  alias FoodDelivery.Cart
  alias FoodDelivery.Cart.Order

  action_fallback(FoodDeliveryWeb.FallbackController)

  def index(conn, _params) do
    user = Pow.Plug.current_user(conn)

    orders = Cart.list_orders(user)

    render(conn, "index.json", orders: orders)
  end

  def create(conn, %{"order_meal" => order_meal_params}) do
    with {:ok, %{updated_order: %Order{} = order}} <-
           Cart.create_or_update_meal_order(order_meal_params) do
      conn
      |> put_resp_header("location", Routes.order_path(conn, :show, order))
      |> render("show.json", order: order)
    end
  end

  def show(conn, %{"id" => id}) do
    user = Pow.Plug.current_user(conn)

    with {:ok, order} <- Cart.get_order(id),
         :ok <- Bodyguard.permit(FoodDelivery.Policy, :show_order, user, order) do
      render(conn, "show.json", order: order)
    end
  end

  def update(conn, %{"id" => id, "order" => order_params}) do
    user = Pow.Plug.current_user(conn)

    with {:ok, order} <- Cart.get_order(id),
         :ok <- Bodyguard.permit(FoodDelivery.Policy, :update_order, user, order),
         {:ok, %Order{} = order} <- Cart.update_order(order, order_params) do
      render(conn, "show.json", order: order)
    end
  end

  def delete(conn, %{"id" => id}) do
    user = Pow.Plug.current_user(conn)

    with {:ok, order} <- Cart.get_order(id),
         :ok <- Bodyguard.permit(FoodDelivery.Policy, :delete_order, user, order),
         {:ok, %Order{}} <- Cart.delete_order(order) do
      send_resp(conn, :no_content, "")
    end
  end

  def change_status(conn, %{"id" => id, "status" => status}) do
    user = Pow.Plug.current_user(conn)

    with {:ok, order} <- Cart.get_order(id),
         :ok <-
           Bodyguard.permit(FoodDelivery.Policy, :change_status_order, user, %{
             order: order,
             new_status: status
           }),
         {:ok, %Order{} = order} <- Cart.change_status(order, status) do
      render(conn, "show.json", order: order)
    end
  end
end
