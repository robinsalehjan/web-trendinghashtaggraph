use Mix.Config

config :web, Web.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "ZMMwNzc0Mpr7Wq3zLOzzHvSyO7XDx9fPyFKx0l9sHSnKyJvgHBw0rCZQPVY/2CJ7",
  render_errors: [view: Web.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Web.PubSub,
           adapter: Phoenix.PubSub.PG2]

config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

import_config "#{Mix.env}.exs"