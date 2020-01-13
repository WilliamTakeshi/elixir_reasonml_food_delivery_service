defmodule FoodDeliveryWeb.ResetPasswordController do
  use FoodDeliveryWeb, :controller

  alias Plug.Conn
  alias PowResetPassword.{Phoenix.Mailer, Plug}

  @spec create(Conn.t(), map()) :: Conn.t()
  def create(conn, %{"user" => user_params}) do
    case Plug.create_reset_token(conn, user_params) do
      {:ok, %{token: token, user: user}, conn} ->
        url = confirmation_url(token)
        deliver_email(conn, user, url)
        conn |> create_success()

      {:error, _any, conn} ->
        conn
        |> create_success()
    end
  end

  def update(conn, %{"user" => user_params, "id" => token}) do
    case Plug.user_from_token(conn, token) do
      nil ->
        conn
        |> put_status(401)
        |> json(%{error: %{status: 401, message: "Invalid reset token"}})

      user ->
        update_user(conn, user, user_params)
    end

    conn
    |> json(%{success: %{message: "Reset password"}})
  end

  defp update_user(conn, user, user_params) do
    conn = conn |> Plug.assign_reset_password_user(user)

    case Plug.update_user_password(conn, user_params) do
      {:ok, _user, conn} ->
        conn
        |> json(%{success: %{message: "Password updated successfully"}})

      {:error, changeset, conn} ->
        conn
        |> put_status(:unprocessable_entity)
        |> put_view(FoodDeliveryWeb.ChangesetView)
        |> render("error.json", changeset: changeset)
    end
  end

  defp create_success(conn) do
    conn |> json(%{success: %{message: "Password reset email sent"}})
  end

  defp confirmation_url(token) do
    Application.get_env(:food_delivery, FoodDeliveryWeb.Endpoint)[:front_end_reset_password_url]
    |> String.replace("{token}", token)
  end

  defp deliver_email(conn, user, url) do
    email = Mailer.reset_password(conn, user, url)
    Pow.Phoenix.Mailer.deliver(conn, email)
  end
end
