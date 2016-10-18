defmodule HashtagGraph.Graph.Vertex do
  @moduledoc false

  @type t :: %__MODULE__{}

  defstruct [:hashtag, :edges]
end
