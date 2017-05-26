# TrendingHashtagGraph
[![Build Status](https://travis-ci.org/robinsjdotcom/trendinghashtaggraph.svg?branch=master)](https://travis-ci.org/robinsjdotcom/trendinghashtaggraph)
[![Deps Status](https://beta.hexfaktor.org/badge/all/github/robinsjdotcom/TrendingHashtagGraph.svg)](https://beta.hexfaktor.org/github/robinsjdotcom/TrendingHashtagGraph)

See the most trending hashtags on Twitter and their adjacent tweets.

URL: https://trendinghashtaggraph.herokuapp.com

JSON: https://trendinghashtaggraph.herokuapp.com/api/graph

![ScreenShot](https://github.com/robinsjdotcom/TrendingHashtagGraph/blob/master/Screenshot.png)

# Goals for this project

- [x] Become comfortable with the actor model
- [x] Build something for the web

# Note to myself

- Before any coding:
  1. Use git-flow
  2. Set-up the CI environment first
  3. Add Pronto with the proper runners for automated code reviews 

- When using 3rd party API's always create two oauth credentials:
  1. One for testing so it can be used in an CI environment. Then you can run transparent tests on the CI infrastructure, without it counting towards the rate limit for the oauth credentials used in production.
  2. The second one for the application deployed to production.

- Always encapsulate untrusted sources of data
  1. Use exceptions to avoid it from spilling into the other parts of the system.
  2. Proper abstraction and design patterns is the idiomatic way of handling uncertainty.
