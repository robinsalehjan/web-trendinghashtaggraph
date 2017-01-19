defmodule HashtagGraph.Graph.Vertex do
  @moduledoc false

  @type t :: %__MODULE__{
    hashtag: atom,
    edges: list
  }

  defstruct [:hashtag, :edges]
end
