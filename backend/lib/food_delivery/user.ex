defmodule FoodDelivery.Users do
  alias FoodDelivery.{Repo, Users.User}

  @type t :: %User{}

  @spec create_admin(map()) :: {:ok, t()} | {:error, Ecto.Changeset.t()}
  def create_admin(params) do
    %User{}
    |> User.changeset(params)
    |> User.changeset_role(%{role: "admin"})
    |> Repo.insert()
  end

  @spec set_admin_role(t()) :: {:ok, t()} | {:error, Ecto.Changeset.t()}
  def set_admin_role(user) do
    user
    |> User.changeset_role(%{role: "admin"})
    |> Repo.update()
  end

  @spec create_owner(map()) :: {:ok, t()} | {:error, Ecto.Changeset.t()}
  def create_owner(params) do
    %User{}
    |> User.changeset(params)
    |> User.changeset_role(%{role: "owner"})
    |> Repo.insert()
  end

  @spec set_owner_role(integer) :: {:ok, t()} | {:error, Ecto.Changeset.t()}
  def set_owner_role(id) do
    Repo.get(User, id)
    |> User.changeset_role(%{role: "owner"})
    |> Repo.update()
  end

  def get_by_email(email) do
    case Repo.get_by(User, email: email) do
      nil -> {:error, :not_found}
      user -> {:ok, user}
    end
  end
end
