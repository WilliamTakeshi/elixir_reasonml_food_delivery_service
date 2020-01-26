defmodule FoodDelivery.Permission do
  @moduledoc """
  The Permission context.
  """

  import Ecto.Query, warn: false
  alias FoodDelivery.Repo

  alias FoodDelivery.Permission.Block

  @doc """
  Returns the list of blocks.

  ## Examples

      iex> list_blocks()
      [%Block{}, ...]

  """
  def list_blocks(user) do
    Repo.all(
      from(b in Block,
        join: r in assoc(b, :restaurant),
        where: r.owner_id == ^user.id
      )
    )
  end

  @doc """
  Gets a single block.

  Returns {:error, :not_found} if the Block does not exist.

  ## Examples

      iex> get_block(123)
      {:ok, %Block{}}

      iex> get_block(456)
      ** {:error, :not_found}

  """
  def get_block(id, user) do
    block =
      Repo.one(
        from(b in Block,
          join: r in assoc(b, :restaurant),
          where: r.owner_id == ^user.id,
          where: b.id == ^id
        )
      )

    case block do
      nil -> {:error, :not_found}
      block -> {:ok, block}
    end
  end

  @doc """
  Creates a block.

  ## Examples

      iex> create_block(%{field: value})
      {:ok, %Block{}}

      iex> create_block(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_block(attrs \\ %{}) do
    %Block{}
    |> Block.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a block.

  ## Examples

      iex> update_block(block, %{field: new_value})
      {:ok, %Block{}}

      iex> update_block(block, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_block(%Block{} = block, attrs) do
    block
    |> Block.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Block.

  ## Examples

      iex> delete_block(block)
      {:ok, %Block{}}

      iex> delete_block(block)
      {:error, %Ecto.Changeset{}}

  """
  def delete_block(%Block{} = block) do
    Repo.delete(block)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking block changes.

  ## Examples

      iex> change_block(block)
      %Ecto.Changeset{source: %Block{}}

  """
  def change_block(%Block{} = block) do
    Block.changeset(block, %{})
  end
end
