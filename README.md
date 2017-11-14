# TrendingHashtagGraph
[![Build Status](https://travis-ci.org/robinsalehjan/trendinghashtaggraph.svg?branch=master)](https://travis-ci.org/robinsalehjan/trendinghashtaggraph)
[![Deps Status](https://beta.hexfaktor.org/badge/all/github/robinsjdotcom/TrendingHashtagGraph.svg)](https://beta.hexfaktor.org/github/robinsjdotcom/TrendingHashtagGraph)

See the most trending hashtags on Twitter and their adjacent tweets.

URL: https://trendinghashtaggraph.herokuapp.com

JSON representation of the Graph: https://trendinghashtaggraph.herokuapp.com/api/graph

![Alt Text](https://github.com/robinsjdotcom/trendinghashtaggraph/blob/master/example.gif)

# Note to myself

- Before any coding:
  1. Set-up the CI environment first
  2. Add Pronto with the proper runners for automated code reviews 

- Always throttle and encapsulate external systems
  1. Never fully trust 3rd party APIs
  2. Use exceptions to avoid it from spilling into the other parts of the system.
  3. Design patterns and proper abstractions is the idiomatic way of handling complexity.
