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
- [How to generate a Phoenix secret](https://hexdocs.pm/phoenix/Mix.Tasks.Phx.Gen.Secret.html)
- [How to get Twitter API credentials](https://developer.twitter.com/en/docs/basics/authentication/guides/access-tokens.html)

2. Pull the image from docker hub: `docker pull robinsalehjan/thg:v1`

3. Run the image: `docker run -d -p 8080:8080 --env-file env.list --rm robinsalehjan/thg` and open `localhost:8080` in your browser

# Terminology & Architecture

In Elixir, all code runs inside processes. Processes are isolated from each other, run concurrent to one another and communicate via message passing. 
Processes are not only the basis for concurrency in Elixir, but they also provide the means for building distributed and fault-tolerant programs. Elixir’s processes should not be confused with operating system processes. Processes in Elixir are extremely lightweight in terms of memory and CPU (even compared to threads as used in many other programming languages).  Because of this, it is not uncommon to have tens or even hundreds of thousands of processes running simultaneously. [1](https://elixir-lang.org/getting-started/processes.html)

Supervision strategies
:one_for_one - if a child process terminates, only that process is restarted.
:one_for_all - if a child process terminates, all other child processes are terminated and then all child processes (including the terminated one) are restarted.
:rest_for_one - if a child process terminates, the terminated child process and the rest of the children started after it, are terminated and restarted.

![Alt Text](https://github.com/robinsjdotcom/trendinghashtaggraph/blob/master/imgs/architecture.png)
