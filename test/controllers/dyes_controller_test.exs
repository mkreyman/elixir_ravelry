defmodule ElixirRavelryWeb.DyesControllerTest do
  use ElixirRavelryWeb.ConnCase

  import ElixirRavelry.{DyesCase}

  # Callbacks

  setup %{conn: conn} do
    bolt_sips_conn = Bolt.Sips.conn()
                     |> Bolt.Sips.begin()

    on_exit fn ->
      Bolt.Sips.rollback(bolt_sips_conn)
    end

    conn = Plug.Conn.put_private(conn, :bolt_sips_conn, bolt_sips_conn)

    %{bolt_sips_conn: bolt_sips_conn, conn: conn}
  end

  # Test

  test "GET /api/v1/dyes without dyes", %{conn: conn} do
    conn = get conn, "/api/v1/dyes"
    assert json_response(conn, 200) == []
  end

  test "GET /api/v1/dyes with dyes", %{bolt_sips_conn: bolt_sips_conn, conn: conn} do
    dyes = create_dyes(bolt_sips_conn)
    conn = get conn, "/api/v1/dyes"
    assert json_response(conn, 200) == [%{"id" => dyes.id, "user_id" => dyes.user_id, "dyed_roving_id" => dyes.dyed_roving_id}]
  end

  test "GET /api/v1/dyes/:id without dyes", %{conn: conn} do
    conn = get conn, "/api/v1/dyes/-1"
    assert json_response(conn, 404) == %{"error" => "Not Found"}
  end

  test "GET /api/v1/dyes/:id with dyes", %{bolt_sips_conn: bolt_sips_conn, conn: conn} do
    dyes = create_dyes(bolt_sips_conn)
    conn = get conn, "/api/v1/dyes/#{dyes.id}"
    assert json_response(conn, 200) == %{"id" => dyes.id, "user_id" => dyes.user_id, "dyed_roving_id" => dyes.dyed_roving_id}
  end

end