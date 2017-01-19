use Mix.Config

config :extwitter, :oauth, [
  consumer_key: System.get_env("TEST_TWITTER_CONSUMER_KEY"),
  consumer_secret: System.get_env("TEST_TWITTER_CONSUMER_SECRET"),
  access_token: System.get_env("TEST_TWITTER_ACCESS_TOKEN"),
  access_token_secret: System.get_env("TEST_TWITTER_ACCESS_TOKEN_SECRET")
]
