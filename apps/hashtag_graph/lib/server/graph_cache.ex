defmodule HashtagGraph.GraphCache do
  @moduledoc """
  Creates a cache of the current state of the `GraphServer` state. The cache
  is per process and updates at it's current state, at a interval of 15 minutes.
  """
  use GenServer

  alias HashtagGraph.GraphServer, as: GraphServer

  ### Client ###

  def start_link(opts \\ []) do
    GenServer.start_link(__MODULE__, :ok, opts)
  end

  def fetch_graph(pid) do
    GenServer.call(pid, :get, 15_000)
  end

  ### Callbacks ###

  def init(:ok) do
    send(self(), :init)
    {:ok, []}
  end

  def handle_call(:get, _from, state) do
    {:reply, state, state}
  end

  def handle_info(:init, _state) do
    new_state = GraphServer.fetch_graph()
    schedule_update()
    {:noreply, new_state}
  end

  def handle_info(:update, _state) do
    new_state = GraphServer.fetch_graph()
    schedule_update()
    {:noreply, new_state}
  end

  # Catch-all clause for unknown messages
  def handle_info(_msg, state) do
    {:noreply, state}
  end

  defp schedule_update() do
    Process.send_after(self(), :update, 1000 * 60 * 30)
  end
end