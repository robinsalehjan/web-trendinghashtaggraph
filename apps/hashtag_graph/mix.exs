defmodule HashtagGraph.Mixfile do
  @moduledoc false
  use Mix.Project

  @spec project() :: list

  def project() do
    [app: :hashtag_graph,
     version: "0.1.0",
     build_path: "../../_build",
     config_path: "../../config/config.exs",
     deps_path: "../../deps",
     lockfile: "../../mix.lock",
     elixir: "~> 1.3",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps()]
  end

  @spec application() :: list

  def application() do
    [mod: {HashtagGraph, []},
    extra_applications: [:logger, :eex, :public_key, :extwitter, :oauther]]
  end

  @spec deps() :: list

  defp deps() do
    [{:oauth, github: "tim/erlang-oauth"},
    {:extwitter, "~> 0.8"}]
  end
end
