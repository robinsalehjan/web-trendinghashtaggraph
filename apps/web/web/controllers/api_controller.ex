defmodule Web.ApiController do
  use Web.Web, :controller
  alias HashtagGraph.GraphCacheSupervisor, as: GraphCacheSupervisor
  alias HashtagGraph.GraphCache, as: GraphCache

  @spec index(Plug.Conn.t, any) :: Plug.Conn.t

  def index(conn, _params) do
    {:ok, child_pid} = GraphCacheSupervisor.add_child()
    state = GraphCache.fetch_graph(child_pid)
    :ok = GraphCacheSupervisor.delete_child(child_pid)
    json(conn, state)
  end
end
