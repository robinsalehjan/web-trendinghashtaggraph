defmodule HashtagGraph do
  @moduledoc false

  use Application

  @spec start(any, any) :: {:error, any} | {:ok, pid} | {:ok , pid, any}

  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    :ok = configure_twitter_client()

    children = [
      worker(HashtagGraph.GraphServer, []),
      supervisor(HashtagGraph.GraphCacheSupervisor , [])
    ]

    opts = [strategy: :one_for_one, name: HashtagGraph.Supervisor]
    Supervisor.start_link(children, opts)
  end

  @doc """
  Fetch the Twitter API credentials, decode them from base64 and initalize
  the ExTwitter client.
  """
  defp configure_twitter_client do
    {:ok, consumer_key} = Base.decode64(System.get_env("TWITTER_CONSUMER_KEY"))
    {:ok, consumer_secret} = Base.decode64(System.get_env("TWITTER_CONSUMER_SECRET"))
    {:ok, access_token} = Base.decode64(System.get_env("TWITTER_ACCESS_TOKEN"))
    {:ok, access_token_secret} = Base.decode64(System.get_env("TWITTER_ACCESS_TOKEN_SECRET"))

    ExTwitter.configure(
      consumer_key: consumer_key,
      consumer_secret: consumer_secret,
      access_token: access_token,
      access_token_secret: access_token_secret
    )
  end
end
