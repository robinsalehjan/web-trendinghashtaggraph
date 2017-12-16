use Mix.Config

config :extwitter, :oauth, [
  consumer_key: "${TEST_TWITTER_CONSUMER_KEY}",
  consumer_secret: "${TEST_TWITTER_CONSUMER_SECRET}",
  access_token: "${TEST_TWITTER_ACCESS_TOKEN}",
  access_token_secret: "${TEST_TWITTER_ACCESS_TOKEN_SECRET}"
]