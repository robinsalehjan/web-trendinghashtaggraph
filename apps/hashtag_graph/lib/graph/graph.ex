defmodule HashtagGraph.Graph do
  @moduledoc """
  Creates a Graph based on hashtags trending at any geolocation.
  By default we use the worldwide trending hashtags.
  """
  alias HashtagGraph.Graph.Vertex, as: Vertex

  @worldwide_yahoo_where_on_earth_id 1

  @doc """
  Constructs a graph for each trending hashtag with related tweets as adjacent vertices.

  By default we use 1 which represents the worldwide Yahoo! Where On Earth ID.
  This identifier tells the Twitter API about the geolocation of interest.

  See https://developer.yahoo.com/geo/geoplanet/ for other geolocation identifiers.
  """
  @spec create_graph() :: {:ok, [vertex]} | {:reschedule, []}

  def create_graph(woed \\ @worldwide_yahoo_where_on_earth_id) do
    with {:ok, _remaining} <- exceeded_limit?(),
      {:ok, hashtags} <- trending_hashtags(woed),
      valid_hashtags <- Stream.filter(hashtags, &(Map.get(&1, :query) != nil)),
      queries <- Stream.map(valid_hashtags, &(Map.get(&1, :query)))
    do
      {:ok, Enum.map(queries, &get_vertex/1)}
    else
      {:reschedule, []} -> {:reschedule, []}
      _ -> throw RuntimeError.message("Error #{System.stacktrace}")
    end
  end

  @doc """
  Fetches the top 10 trending hashtags on Twitter based on the Yahoo! Where On Earth ID.
  """
  @spec trending_hashtags(Integer.t | String.t) :: {:ok, [hashtag]}
                                                   | {:error, List.t}

  def trending_hashtags(woed) when is_integer(woed) do
    {:ok, ExTwitter.trends(woed, [])}
  end

  def trending_hashtags(woed) when is_binary(woed) do
    {:ok, ExTwitter.trends(woed, [])}
  end

  def trending_hashtags(_woed) do
    {:error, []}
  end

  @doc """
  Sends a request to the Twitter API, to determine if the API limit has been exceeded.
  """
  @spec exceeded_limit?() :: {:ok, Integer.t}
                             | {:error, String.t}
                             | no_return

  def exceeded_limit?() do
    remaning_calls = search_api_limit()
    cond do
      remaning_calls >= 50 -> {:ok, remaning_calls}
      remaning_calls <= 50 -> {:error, "exceeded API limit"}
      true -> throw RuntimeError.message("Error\n#{System.stacktrace}")
    end
  end

  # Fetches the remaining numbers of calls available for the "resources/search/" endpoint
  @spec search_api_limit() :: Integer.t

  defp search_api_limit() do
    limit = ExTwitter.rate_limit_status(resources: "search")
    Kernel.get_in(limit, [:resources, :search, :"/search/tweets", :remaining])
  end


  # Fetches 5 tweets with the hashtag provided as argument
  @spec tweets(String.t) :: {:ok, [tweet]} | {:reschedule, []}

  defp tweets(hashtag) do
    response =
      try do
        {:ok, ExTwitter.search(hashtag, count: 5)}
      catch
        _ -> {:reschedule, []}
      end

    case response do
      {:ok, response} -> {:ok, response}
      {:reschedule, []} ->  {:reschedule, []}
      _ -> throw RuntimeError.message("Error\n#{System.stacktrace}")
    end
  end

  @doc """
  Creates a vertex for the given hashtag with recent tweets as adjacent vertices.
  """
  @spec get_vertex(String.t) :: HashtagGraph.Graph.Vertex.t
                                | {:error, String.t}
                                | no_return

  # Create a vertex with the given hashtag and recent tweets as adjacent vertices.
  @spec get_vertex(String.t) :: vertex | {:reschedule, []}

  defp get_vertex(hashtag) do
    with {:ok, _remaining} <- exceeded_limit?(),
      {:ok, tweets} <- tweets(hashtag),
      valid_tweets <- Stream.filter(tweets, &(Map.get(&1, :text) != nil)),
      edges <- Enum.map(valid_tweets, &(Map.get(&1, :text)))
    do
      %Vertex{hashtag: hashtag, edges: edges}
    else
      {:reschedule, []} -> {:reschedule, []}
      true -> throw RuntimeError.message("Error\n#{System.stacktrace}")
    end
  end
end
