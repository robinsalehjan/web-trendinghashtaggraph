defmodule HashtagGraph.GraphServer do
  @moduledoc """
  At 30 minutes intervals updates the state of the graph datastructure to reflect
  the trending hashtags and tweets on Twitter.

  This is a singleton GenServer, for concurrent access it's recommended to
  use the `HashtagGraph.GraphCache` module.
  """
  use GenServer
  require Logger

  alias HashtagGraph.Graph, as: Graph

  @name GraphServer

  ### Client ###

  def start_link() do
    GenServer.start_link(__MODULE__, {:ok, []}, name: GraphServer)
  end

  @doc """
  Returns the current state of the graph datastructure.
  """
  def fetch_graph() do
    GenServer.call(@name, :get, 30_000)
  end

  ### Callbacks ###

  def init({:ok, state}) do
    send(@name, :init)  # Delay state initialization
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
      {:api_limit, _} ->
        schedule_api_call(:ok)
        {:noreply, state}

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
      {:api_limit, _} ->
        Logger.info("Exceeded API quota trying to update state")
        schedule_api_call(:ok)
        {:noreply, state}

      {:reschedule, _} ->
        Logger.warn("Rescheduling API call due to error while updating state")
        schedule_api_call(:reschedule)
        {:noreply, state}
    end
  end

  # Catch-all clause for unknown messages
  def handle_info(_msg, state) do
    {:noreply, state}
  end

  # Schedules a API call to execute in 15 minutes.
  defp schedule_api_call(:ok) do
    Process.send_after(@name, :update, 1000 * 60 * 15)
    Logger.info("Scheduled API call to fetch API data after 15 minutes")
  end

  # Reschedules the failed API call to execute in 5 seconds.
  defp schedule_api_call(:reschedule) do
    Process.send_after(@name, :update, 5_000)
    Logger.info("Rescheduled API call to execute after 5 seconds")
  end
end
