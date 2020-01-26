defmodule FoodDelivery.PermissionTest do
  use FoodDelivery.DataCase

  alias FoodDelivery.Permission

  describe "blocks" do
    alias FoodDelivery.Permission.Block

    @valid_attrs %{}
    @update_attrs %{}
    @invalid_attrs %{}

    def block_fixture(attrs \\ %{}) do
      {:ok, block} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Permission.create_block()

      block
    end

    test "list_blocks/0 returns all blocks" do
      block = block_fixture()
      assert Permission.list_blocks() == [block]
    end

    test "get_block!/1 returns the block with given id" do
      block = block_fixture()
      assert Permission.get_block!(block.id) == block
    end

    test "create_block/1 with valid data creates a block" do
      assert {:ok, %Block{} = block} = Permission.create_block(@valid_attrs)
    end

    test "create_block/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Permission.create_block(@invalid_attrs)
    end

    test "update_block/2 with valid data updates the block" do
      block = block_fixture()
      assert {:ok, %Block{} = block} = Permission.update_block(block, @update_attrs)
    end

    test "update_block/2 with invalid data returns error changeset" do
      block = block_fixture()
      assert {:error, %Ecto.Changeset{}} = Permission.update_block(block, @invalid_attrs)
      assert block == Permission.get_block!(block.id)
    end

    test "delete_block/1 deletes the block" do
      block = block_fixture()
      assert {:ok, %Block{}} = Permission.delete_block(block)
      assert_raise Ecto.NoResultsError, fn -> Permission.get_block!(block.id) end
    end

    test "change_block/1 returns a block changeset" do
      block = block_fixture()
      assert %Ecto.Changeset{} = Permission.change_block(block)
    end
  end
end
