defmodule ElixirRavelry.Repo.Owns do
  @moduledoc false

  alias ElixirRavelryWeb.Owns
  alias ElixirRavelry.Repo

  # Macros

  @impl ElixirRavelry.Repo.Relationship
  defmacro type, do: "OWNS"
  use ElixirRavelry.Repo.Relationship

  #Functions

  @impl ElixirRavelry.Repo.Relationship
  def create(conn, %Owns{started_at: started_at, user_id: user_id, wool_id: wool_id}) do
    Repo.create_relationship(conn, %{type: type(), end_node_id: wool_id, start_node_id: user_id, started_at: Repo.to_timestamp(started_at)})
  end

  @impl ElixirRavelry.Repo.Relationship
  def row_to_struct(
        %Bolt.Sips.Types.Relationship{
          "end": wool_id,
          id: id,
          properties: %{
            "started_at" => started_at_timestamp
          },
          start: user_id,
          type: type()
        }
      ) do
    %Owns{
      __meta__: %Ecto.Schema.Metadata{
        source: {nil, type()},
        state: :loaded
      },
      id: id,
      wool_id: wool_id,
      user_id: user_id,
      started_at: Repo.from_timestamp(started_at_timestamp)
    }
  end
end