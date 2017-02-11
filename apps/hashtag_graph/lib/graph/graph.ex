defmodule HashtagGraph.Graph do
  @moduledoc """
  Creates a Graph based on hashtags trending at any geolocation.
  By default we use the worldwide trending hashtags.
  """
  alias HashtagGraph.Graph.Vertex, as: Vertex

  @type trending_hashtag :: ExTwitter.Model.Trend.t
  @type tweet :: ExTwitter.Model.Tweet.t
  @type vertex :: Vertex.t
  @type graph :: [%Vertex{hashtag: String.t, edges: [vertex]}]

  @worldwide_woed 1


  @doc """
  Constructs a graph for each trending hashtag with related tweets as adjacent vertices.

  By default we use 1 which represents the worldwide Yahoo! Where On Earth ID.
  This identifier tells the Twitter API about the geolocation of interest.

  See https://developer.yahoo.com/geo/geoplanet/ for other geolocation identifiers.
  """
  @spec create_graph() :: {:ok, graph}
                          | {:api_limit, number}
                          | {:reschedule, []}

  def create_graph() do
    with {:ok, _} <- exceeded_limit?(),
      {:ok, hashtags} <- trending_hashtags(@worldwide_woed),
      filtered <- Stream.filter(hashtags, &(Map.get(&1, :query) != nil)),
      queries <- Stream.map(filtered, &(Map.get(&1, :query)))
    do
      {:ok, construct_graph(queries)}
    else
      {:api_limit, 0} -> {:api_limit, 0}
      {:reschedule, []} -> {:reschedule, []}
      _ -> raise("Error\n#{System.stacktrace}")
    end
  end

  # Create every vertex and filter away errors
  @spec construct_graph([String.t]) :: {:ok, graph}

  defp construct_graph(hashtags) do
    hashtags
    |> Stream.map(&create_vertex/1)
    |> Enum.filter(fn(vertex) -> is_map(vertex) end)
  end


  @doc """
  Determines if the API limit has been exceeded.
  """
  @spec exceeded_limit?() :: {:ok, number}
                             | {:api_limit, number}

  def exceeded_limit?() do
    remaning_calls = search_api_limit()
    cond do
      remaning_calls >= 50 -> {:ok, remaning_calls}
      remaning_calls <= 50 -> {:api_limit, 0}
      true -> raise("Error\n#{System.stacktrace}")
    end
  end


  # Fetch the remaining API calls for the "resources/search/" endpoint
  @spec search_api_limit() :: any

  defp search_api_limit() do
    limit = ExTwitter.rate_limit_status(resources: "search")
    Kernel.get_in(limit, [:resources, :search, :"/search/tweets", :remaining])
  end


  @doc """
  Fetches the top 10 trending hashtags based on the Yahoo! Where On Earth ID.
  """
  @spec trending_hashtags(number | String.t | Keyword.t) :: {:ok, [trending_hashtag]}

  def trending_hashtags(woed) do
    {:ok, ExTwitter.trends(woed, [])}
  end

  # Create a vertex with the given hashtag and recent tweets as adjacent vertices.
  @spec create_vertex(String.t) :: vertex
                                | {:api_limit, number}
                                | {:reschedule, []}

  defp create_vertex(hashtag) do
    with {:ok, _remaining} <- exceeded_limit?(),
      {:ok, tweets} <- tweets(hashtag),
      valid_tweets <- Stream.filter(tweets, &(Map.get(&1, :text) != nil)),
      edges <- Enum.map(valid_tweets, &(Map.get(&1, :text)))
    do
      %Vertex{hashtag: hashtag, edges: edges}
    else
      {:api_limit, 0} -> {:api_limit, 0}
      {:reschedule, []} -> {:reschedule, []}
      true -> raise("Error\n#{System.stacktrace}")
    end
  end


  # Fetches 5 tweets with the hashtag provided as argument
  @spec tweets(String.t) :: {:ok, [tweet]}
                            | {:reschedule, []}

  defp tweets(hashtag) do
    response =
      try do
        {:ok, ExTwitter.search(hashtag, count: 5)}
      rescue
        _ -> {:reschedule, []}
      end

    case response do
      {:ok, response} -> {:ok, response}
      {:reschedule, []} ->  {:reschedule, []}
      _ -> raise("Error\n#{System.stacktrace}")
    end
  end
end
