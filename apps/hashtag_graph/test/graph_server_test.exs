defmodule HashtagGraphTest do
  @moduledoc """

  """
  use ExUnit.Case
  alias HashtagGraph.GraphServer, as: GraphServer

  setup do
    Application.stop(:hashtag_graph)
    :ok = Application.start(:hashtag_graph)
  end
end
