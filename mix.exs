defmodule TrendingHashtagGraph.Mixfile do
  @moduledoc false
  use Mix.Project

  def project do
    [apps_path: "apps",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps(),
     dialyzer: [plt_add_deps: :transitive, flags: [["-Woverspecs",
                                                    "-Werror_handling",
                                                    "-Wrace_conditions"]]]
   ]
  end

  defp deps() do
    [{:credo, "~> 0.6.0", only: [:dev, :test]},
     {:dialyxir, "~> 0.4.0", only: [:dev]},
     {:distillery, "~> 1.5"}]
  end
end
