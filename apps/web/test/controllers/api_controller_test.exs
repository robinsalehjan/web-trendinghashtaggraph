defmodule Web.ApiControllerTest do
  @moduledoc false
  use ExUnit.Case, async: true
  use Plug.Test

  test "/api/graph returns json object" do
    response = conn(:get, "/api/graph") |> send_request
    assert response.status == 200
    assert response.resp_body != nil
  end

  defp send_request(conn) do
    conn
    |> put_private(:plug_skip_csrf_protection, true)
    |> Web.Endpoint.call([])
  end
end
