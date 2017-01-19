defmodule Web.PageController do
  use Web.Web, :controller
  alias HashtagGraph.GraphCacheSupervisor, as: GraphCacheSupervisor
  alias HashtagGraph.GraphCache, as: GraphCache

  def index(conn, _params) do
    render(conn, "index.html")
  end

  def get_graph(conn, _params) do
    {:ok, child_pid} = GraphCacheSupervisor.add_child()
    state = GraphCache.fetch_graph(child_pid)
    :ok = GraphCacheSupervisor.delete_child(child_pid)
    json(conn, %{"200": state})
  end
end
