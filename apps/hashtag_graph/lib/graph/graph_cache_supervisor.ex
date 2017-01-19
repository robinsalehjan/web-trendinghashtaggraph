defmodule HashtagGraph.GraphCacheSupervisor do
  @moduledoc """
  Dynamically add `GraphCache` processes as children of the `GraphCacheSupervisor`.
  """
  use Supervisor

  @name GraphCacheSupervisor

  ### Client ###

  def start_link() do
    Supervisor.start_link(__MODULE__, :ok, name: @name)
  end

  @doc """
  Add a `HashtagGraph.GraphCache` process to the supervisor.
  """
  def add_child() do
    Supervisor.start_child(@name, [])
  end

  @doc """
  Delete the `child_pid` process process from the supervisor
  """
  def delete_child(child_pid) do
    Supervisor.terminate_child(@name, child_pid)
  end

  ### Callbacks ###

  def init(:ok) do
    children = [
      worker(HashtagGraph.GraphCache, [], restart: :transient)
    ]

    supervise(children, strategy: :simple_one_for_one)
  end
end