defmodule FoodDeliveryWeb.BlockView do
  use FoodDeliveryWeb, :view
  alias FoodDeliveryWeb.BlockView

  def render("index.json", %{blocks: blocks}) do
    %{data: render_many(blocks, BlockView, "block.json")}
  end

  def render("show.json", %{block: block}) do
    %{data: render_one(block, BlockView, "block.json")}
  end

  def render("block.json", %{block: block}) do
    block
  end
end
