# TrendingHashtagGraph
[![Build Status](https://travis-ci.org/robinsjdotcom/TrendingHashtagGraph.svg?branch=master)](https://travis-ci.org/robinsjdotcom/TrendingHashtagGraph)
[![Deps Status](https://beta.hexfaktor.org/badge/all/github/robinsjdotcom/TrendingHashtagGraph.svg)](https://beta.hexfaktor.org/github/robinsjdotcom/TrendingHashtagGraph)

URL: https://trendinghashtaggraph.herokuapp.com

API: https://trendinghashtaggraph.herokuapp.com/api/graph

View the most trending hashtags on Twitter and see how they are related to other tweets or hashtags.

# Goals for this project

- Learn how to use:
  - Packer to create production deployable images/containers
  - Terraform for automating the creation of our cloud infrastructure
- Creating and deploying Erlang releases with exrm
- [x] Become comfortable with the actor model
- [x] Build something with Javascript


# Note to myself

- When using 3rd party API's always create two oauth credentials:

  1. One for testing so it can be used in an CI environment. Then you can run transparent tests on the CI infrastructure, without it counting towards the rate limit for the oauth credentials used in production.

  2. The second one for the application deployed to production.
