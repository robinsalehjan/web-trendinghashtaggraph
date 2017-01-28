defmodule HashtagGraph.GraphServer do
  @moduledoc """
  At 30 minutes intervals updates the state of the graph datastructure to reflect
  the trending hashtags and tweets on Twitter.

  This is a singleton GenServer, for concurrent access it's recommended to
  use the `HashtagGraph.GraphCache` module.
  """
  use GenServer

  alias HashtagGraph.Graph, as: Graph

  @name GraphServer

  ### Client ###

  def start_link() do
    GenServer.start_link(__MODULE__, {:ok, []}, name: GraphServer)
  end

  def fetch_graph() do
    GenServer.call(@name, :get, 30_000)
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

  def handle_info(:init, state) do
    with {:ok, new_state} <- Graph.create_graph() do
      schedule_api_call(:ok)
      {:noreply, new_state}
    else
      {:reschedule, _} ->
        schedule_api_call(:reschedule)
        {:noreply, state}
    end
  end

  def handle_info(:update, state) do
    with {:ok, new_state} <- Graph.create_graph() do
      schedule_api_call(:ok)
      {:noreply, new_state}
    else
      {:reschedule, _} ->
        schedule_api_call(:reschedule)
        {:noreply, state}
    end
  end

  # Catch-all clause for unknown messages
  def handle_info(_msg, state) do
    {:noreply, state}
  end

  # Schedules a API call to execute in 30 minutes.
  defp schedule_api_call(:ok) do
    Process.send_after(@name, :update, 1000 * 60 * 30)
  end

  # Reschedules the failed API call to execute in 1 minute.
  defp schedule_api_call(:reschedule) do
    Process.send_after(@name, :update, 1000 * 60 * 1)
  end
end
