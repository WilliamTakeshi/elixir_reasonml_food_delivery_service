defmodule FoodDeliveryWeb.BlockController do
  use FoodDeliveryWeb, :controller

  alias FoodDelivery.Menu
  alias FoodDelivery.Permission
  alias FoodDelivery.Permission.Block

  action_fallback(FoodDeliveryWeb.FallbackController)

  def index(conn, %{"restaurant_id" => restaurant_id}) do
    user = Pow.Plug.current_user(conn)

    with {:ok, restaurant} <- Menu.get_restaurant(restaurant_id),
         :ok <- Bodyguard.permit(FoodDelivery.Policy, :index_block, user, restaurant),
         blocks <- Permission.list_blocks(user) do
      render(conn, "index.json", blocks: blocks)
    end
  end

  def create(conn, %{"email" => user_email, "restaurant_id" => restaurant_id}) do
    user = Pow.Plug.current_user(conn)
    {:ok, blocked_user} = FoodDelivery.Users.get_by_email(user_email)

    with {:ok, restaurant} <- Menu.get_restaurant(restaurant_id),
         :ok <- Bodyguard.permit(FoodDelivery.Policy, :create_block, user, restaurant),
         {:ok, %Block{} = block} <-
           Permission.create_block(%{restaurant_id: restaurant_id, user_id: blocked_user.id}) do
      conn
      |> put_status(:created)
      |> put_resp_header(
        "location",
        Routes.restaurant_block_path(conn, :show, restaurant_id, block)
      )
      |> render("show.json", block: block)
    end
  end

  def show(conn, %{"id" => id, "restaurant_id" => restaurant_id}) do
    user = Pow.Plug.current_user(conn)

    with {:ok, restaurant} <- Menu.get_restaurant(restaurant_id),
         :ok <- Bodyguard.permit(FoodDelivery.Policy, :show_block, user, restaurant),
         {:ok, block} <- Permission.get_block(id, user) do
      render(conn, "show.json", block: block)
    end
  end

  def delete(conn, %{"id" => id, "restaurant_id" => restaurant_id}) do
    user = Pow.Plug.current_user(conn)

    with {:ok, restaurant} <- Menu.get_restaurant(restaurant_id),
         :ok <- Bodyguard.permit(FoodDelivery.Policy, :delete_block, user, restaurant),
         {:ok, block} <- Permission.get_block(id, user),
         {:ok, %Block{}} <- Permission.delete_block(block) do
      send_resp(conn, :no_content, "")
    end
  end
end
