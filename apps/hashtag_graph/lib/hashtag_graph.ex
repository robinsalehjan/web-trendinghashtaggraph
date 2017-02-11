defmodule HashtagGraph do
  @moduledoc false

  use Application

  @spec start(any, any) :: {:error, any} | {:ok, pid} | {:ok , pid, any}

  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    children = [
      worker(HashtagGraph.GraphServer, []),
      supervisor(HashtagGraph.GraphCacheSupervisor , [])
    ]

    opts = [strategy: :one_for_one, name: HashtagGraph.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
