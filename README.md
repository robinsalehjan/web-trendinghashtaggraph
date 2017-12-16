# TrendingHashtagGraph

URL:

JSON representation of the Graph:

![Alt Text](https://github.com/robinsjdotcom/trendinghashtaggraph/blob/master/imgs/example.gif)

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

Where `...` is your Phoenix secret and Twitter API credentials and then run: `source env.list`

2. Create the image: `docker build --no-cache --build-arg PORT=${PORT} -t thg .`

3. Run the image: `docker run -d -p 8080:8080 --env-file env.list --rm thg`
   and open `localhost:8080` in your browser

# Note to self

1. Setup CI environment first
2. Add Pronto with the proper runners for automated code reviews
3. Design patterns and proper abstractions is the idiomatic way of handling complexity.
4. Use exceptions to avoid it from spilling into the other parts of the system.
