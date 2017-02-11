defmodule Web do
  @moduledoc false
  use Application

  @spec start(any, any) :: {:error, any} | {:ok, pid} | {:ok , pid, any}

  def start(_type, _args) do
    import Supervisor.Spec

    children = [
      supervisor(Web.Endpoint, [])
    ]

    opts = [strategy: :one_for_one, name: Web.Supervisor]
    Supervisor.start_link(children, opts)
  end

  @spec config_change(any, any, any) :: :ok

  def config_change(changed, _new, removed) do
    Web.Endpoint.config_change(changed, removed)
    :ok
  end
end
