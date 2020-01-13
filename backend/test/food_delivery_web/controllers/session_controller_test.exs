defmodule FoodDeliveryWeb.API.V1.SessionControllerTest do
  use FoodDeliveryWeb.ConnCase

  alias FoodDelivery.{Repo, Users.User}
  alias FoodDeliveryWeb.APIAuthPlug
  alias Pow.Ecto.Schema.Password

  @pow_config [otp_app: :food_delivery]

  setup %{conn: conn} do
    user =
      Repo.insert!(%User{
        email: "test@example.com",
        password_hash: Password.pbkdf2_hash("secret1234")
      })

    {:ok, conn: conn, user: user}
  end

  describe "create/2" do
    @valid_params %{"user" => %{"email" => "test@example.com", "password" => "secret1234"}}
    @invalid_params %{"user" => %{"email" => "test@example.com", "password" => "invalid"}}

    test "with valid params", %{conn: conn} do
      conn = post(conn, Routes.session_path(conn, :create, @valid_params))

      assert json = json_response(conn, 200)
      assert json["data"]["token"]
      assert json["data"]["renew_token"]
    end

    test "with invalid params", %{conn: conn} do
      conn = post(conn, Routes.session_path(conn, :create, @invalid_params))

      assert json = json_response(conn, 401)

      assert json["error"]["message"] == "Invalid email or password"
      assert json["error"]["status"] == 401
    end
  end

  describe "renew/2" do
    setup %{conn: conn, user: user} do
      {authed_conn, _user} = APIAuthPlug.create(conn, user, @pow_config)

      :timer.sleep(100)

      {:ok, conn: conn, renew_token: authed_conn.private[:api_renew_token]}
    end

    test "with valid authorization header", %{conn: conn, renew_token: token} do
      conn =
        conn
        |> Plug.Conn.put_req_header("authorization", token)
        |> post(Routes.session_path(conn, :renew))

      assert json = json_response(conn, 200)
      assert json["data"]["token"]
      assert json["data"]["renew_token"]
    end

    test "with invalid authorization header", %{conn: conn} do
      conn =
        conn
        |> Plug.Conn.put_req_header("authorization", "invalid")
        |> post(Routes.session_path(conn, :renew))

      assert json = json_response(conn, 401)

      assert json["error"]["message"] == "Invalid token"
      assert json["error"]["status"] == 401
    end
  end

  describe "delete/2" do
    setup %{conn: conn, user: user} do
      {authed_conn, _user} = APIAuthPlug.create(conn, user, @pow_config)

      :timer.sleep(100)

      {:ok, conn: conn, auth_token: authed_conn.private[:api_auth_token]}
    end

    test "invalidates", %{conn: conn, auth_token: token} do
      conn =
        conn
        |> Plug.Conn.put_req_header("authorization", token)
        |> delete(Routes.session_path(conn, :delete))

      assert json_response(conn, 200)
      :timer.sleep(100)

      assert {_conn, nil} = APIAuthPlug.fetch(conn, @pow_config)
    end
  end
end
