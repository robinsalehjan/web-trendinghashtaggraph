use Mix.Config

config :web, Web.Endpoint,
  load_from_system_env: true,
  http: [port: "${PORT}"],
  url: [host: "localhost", port: {:system, "${PORT}"}],
  check_origin: false,
  server: true,
  root: ".",
  secret_key_base: "${PHOENIX_SECRET_KEY_BASE}",
  cache_static_manifest: "priv/static/manifest.json"

config :logger, level: :info