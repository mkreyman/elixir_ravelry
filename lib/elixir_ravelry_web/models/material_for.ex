defmodule ElixirRavelryWeb.MaterialFor do
  use ElixirRavelryWeb, :model

  alias ElixirRavelryWeb.Node

  @optional_fields []
  @required_fields [:end_node_id, :start_node_id]
  @allowed_fields @optional_fields ++ @required_fields

  schema "material_for" do
    belongs_to :end_node, Node
    belongs_to :start_node, Node
  end

  def changeset(data, params) do
    data
    |> cast(params, @allowed_fields)
    |> validate_required(@required_fields)
  end

  defimpl Poison.Encoder do
    def encode(%{id: id, end_node_id: end_node_id, start_node_id: start_node_id}, options) do
      Poison.Encoder.Map.encode(%{id: id, end_node_id: end_node_id, start_node_id: start_node_id, type: "MaterialFor"}, options)
    end
  end

end