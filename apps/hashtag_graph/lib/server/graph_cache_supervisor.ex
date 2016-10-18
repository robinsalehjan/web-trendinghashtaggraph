defmodule HashtagGraph.GraphCacheSupervisor do
  @moduledoc """

  """
  use Supervisor

  ### Client ###

  def start_link(opts \\ []) do
    Supervisor.start_link(__MODULE__, opts)
  end

  def add_child(supervisor) do
    Supervisor.start_child(supervisor, [])
  end

  ### Callbacks ###

  def init(_args) do
    children = [
      worker(HashtagGraph.GraphCache, [], restart: :transient)
    ]

    supervise(children, strategy: :simple_one_for_one)
  end
end