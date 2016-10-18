defmodule HashtagGraph.GraphServer do
  @moduledoc """
  At 30 minutes intervals updates the state of the graph structure,
  defined in the `Graph.ex` module.
  """
  use GenServer

  alias HashtagGraph.Graph, as: Graph

  @name GraphServer

  ### Client ###

  def start_link(opts \\ []) do
    state = {:ok, []}
    {:ok, pid} = GenServer.start_link(__MODULE__, state, name: GraphServer)
  end

  def fetch_graph() do
    GenServer.call(@name, :get, 15_000)
  end

  ### Callbacks ###

  def init({:ok, state}) do
    # Delayed initalization
    send(@name, :init)
    {:ok, state}
  end

  def handle_call(:get, _from, state) do
    {:reply, state, state}
  end

  def handle_info(:init, _state) do
    {:ok, new_state} = Graph.create_graph()
    schedule_api_call()
    {:noreply, new_state}
  end

  def handle_info(:update, _state) do
    {:ok, new_state} = Graph.create_graph()
    schedule_api_call()
    {:noreply, new_state}
  end

  # Catch-all clause for unknown messages
  def handle_info(_msg, state) do
    {:noreply, state}
  end

  defp schedule_api_call() do
    Process.send_after(@name, :update, 1000 * 60 * 30)
  end
end
