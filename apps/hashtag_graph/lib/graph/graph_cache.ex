defmodule HashtagGraph.GraphCache do
  @moduledoc """
  Creates a cache around the state of the `GraphServer`. Periodically every 30
  minutes the state of the `GraphCache` process is updated to reflect the state of the `GraphServer`
  """
  use GenServer

  alias HashtagGraph.GraphServer, as: GraphServer
  alias HashtagGraph.Graph.Vertex, as: Vertex

  @type vertex :: Vertex.t
  @type graph :: [%Vertex{hashtag: String.t, edges: [vertex]}]

  ### Client ###
  @spec start_link(list) :: tuple

  def start_link(opts \\ []) do
    GenServer.start_link(__MODULE__, :ok, opts)
  end

  @spec fetch_graph(pid :: identifier) :: graph

  def fetch_graph(pid) do
    GenServer.call(pid, :get, 30_000)
  end

  ### Callbacks ###
  @spec init(:ok) :: {:ok, []}

  def init(:ok) do
    send(self(), :init)  # Delay state initialization
    {:ok, []}
  end

  @spec handle_call(atom, pid :: identifier, graph) :: {:reply, graph, graph}

  def handle_call(:get, _from, state) do
    {:reply, state, state}
  end

  @spec handle_info(atom, graph) :: {:noreply, graph}

  def handle_info(:init, _state) do
    new_state = GraphServer.fetch_graph()
    schedule_update()
    {:noreply, new_state}
  end

  @spec handle_info(atom, graph) :: {:noreply, graph}

  def handle_info(:update, _state) do
    new_state = GraphServer.fetch_graph()
    schedule_update()
    {:noreply, new_state}
  end

  # Catch-all clause for unknown messages
  @spec handle_info(term, graph) :: {:noreply, graph}

  def handle_info(_msg, state) do
    {:noreply, state}
  end

  # Update the internal genserver state every 15 minutes
  @spec schedule_update() :: identifier

  defp schedule_update() do
    Process.send_after(self(), :update, 1000 * 60 * 15)
  end
end