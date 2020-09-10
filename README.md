# TrendingHashtagGraph

![Alt Text](https://github.com/robinsjdotcom/trendinghashtaggraph/blob/master/imgs/example.gif)

# Run with Docker

1. Make sure to create a `env.list` file with the content:
```
PORT=8080
REPLACE_OS_VARS=true
PHOENIX_SECRET_KEY_BASE=...
TWITTER_CONSUMER_KEY=...
TWITTER_CONSUMER_SECRET=...
TWITTER_ACCESS_TOKEN=...
TWITTER_ACCESS_TOKEN_SECRET=...
```

Where you replace the `...` with the value of your Phoenix secret and Twitter API credentials:
- How to generate a Phoenix secret: https://hexdocs.pm/phoenix/Mix.Tasks.Phoenix.Gen.Secret.html
- How to get Twitter API credentials: https://developer.twitter.com/en/docs/basics/authentication/guides/access-tokens.html

2. Pull the image from docker hub: `docker pull robinsalehjan/thg:v1`

3. Run the image: `docker run -d -p 8080:8080 --env-file env.list --rm robinsalehjan/thg` and open `localhost:8080` in your browser

# Architecture
![Alt Text](https://github.com/robinsjdotcom/trendinghashtaggraph/blob/master/imgs/architecture.png)
