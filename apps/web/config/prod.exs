import System
use Mix.Config

{port, _} = System.get_env("PORT") |> Integer.parse

phoenix_secret_key = cond do
  System.get_env("PHOENIX_SECRET_KEY_BASE") == nil -> ""
  true -> Base.decode64!(System.get_env("PHOENIX_SECRET_KEY_BASE"))
end

config :web, Web.Endpoint,
  load_from_system_env: true,
  http: [port: port],
  url: [host: "localhost", port: port],
  check_origin: false,
  server: true,
  root: ".",
  secret_key_base: phoenix_secret_key,
  cache_static_manifest: "priv/static/manifest.json"

config :logger, level: :info