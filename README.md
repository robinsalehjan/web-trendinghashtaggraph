# TrendingHashtagGraph
[![Build Status](https://travis-ci.org/robinsalehjan/trendinghashtaggraph.svg?branch=master)](https://travis-ci.org/robinsalehjan/trendinghashtaggraph)
[![Deps Status](https://beta.hexfaktor.org/badge/all/github/robinsjdotcom/TrendingHashtagGraph.svg)](https://beta.hexfaktor.org/github/robinsjdotcom/TrendingHashtagGraph)

See the most trending hashtags on Twitter and their adjacent tweets.

URL:

JSON representation of the Graph:

![Alt Text](https://github.com/robinsjdotcom/trendinghashtaggraph/blob/master/example.gif)

# Run with Docker

1. Make sure to create a `env.list` with the content:
```
PORT=8080
REPLACE_OS_VARS=true
PHOENIX_SECRET_KEY_BASE=...
TWITTER_CONSUMER_KEY=...
TWITTER_CONSUMER_SECRET=...
TWITTER_ACCESS_TOKEN=...
TWITTER_ACCESS_TOKEN_SECRET=...
```

Where `...` is your Phoenix secret and Twitter API credentials, followed by adding them to the terminal by running: `source env.list`

2. Create the image: `docker build --no-cache --build-arg PORT=${PORT} -t thg .`

3. Run the image: `docker run -t -d -p 8080:8080 --env-file env.list --rm thg`
   and open localhost:8080 in your browser

# Note to myself

- Nice to have:
  1. Setup CI environment first
  2. Add Pronto with the proper runners for automated code reviews

- Encapsulate external components
  1. Design patterns and proper abstractions is the idiomatic way of handling complexity.
  2. Never fully trust 3rd party APIs
  3. Use exceptions to avoid it from spilling into the other parts of the system.