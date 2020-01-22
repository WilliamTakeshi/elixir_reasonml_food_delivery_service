defmodule FoodDeliveryWeb.APIAuthErrorHandler do
  use FoodDeliveryWeb, :controller
  alias Plug.Conn

  @spec call(Conn.t(), :not_authenticated) :: Conn.t()
  def call(conn, :not_authenticated) do
    conn
    |> put_status(401)
    |> json(%{errors: %{detail: "Not authenticated"}})
  end
end
