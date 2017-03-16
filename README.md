# TrendingHashtagGraph
[![Build Status](https://travis-ci.org/robinsjdotcom/trendinghashtaggraph.svg?branch=master)](https://travis-ci.org/robinsjdotcom/trendinghashtaggraph)
[![Deps Status](https://beta.hexfaktor.org/badge/all/github/robinsjdotcom/TrendingHashtagGraph.svg)](https://beta.hexfaktor.org/github/robinsjdotcom/TrendingHashtagGraph)

See the most trending hashtags on Twitter and their adjacent tweets.

URL: https://trendinghashtaggraph.herokuapp.com

JSON: https://trendinghashtaggraph.herokuapp.com/api/graph

![ScreenShot](https://github.com/robinsjdotcom/TrendingHashtagGraph/blob/master/Screenshot.png)

# Blog posts
[Periodic scheduling using a GenServer](https://medium.com/@robinsjdotcom/periodic-scheduling-using-a-genserver-33242b439bc4#.1d2ahei60) - Scheduling simple tasks without using Redis or some type of task queue, is often asked about from people just starting with Elixir. In this post I detail the proper way to schedule tasks using a GenServer.

[Checklist for deploying umbrella applications to Heroku](https://medium.com/@robinsjdotcom/checklist-for-deploying-umbrella-applications-to-heroku-74a79e07e21f#.qspvspxt4) - While trying to deploy this umbrella application to Heroku, there was no resource for the proper way to do so. I made this post to detail how to deploy umbrella applications to Heroku.

# Goals for this project

- Learn how to use:
  - Packer to create production deployable images/containers
  - Terraform for automating the creation of cloud infrastructure
- Creating and deploying Erlang releases with exrm
- [x] Become comfortable with the actor model
- [x] Build something with Javascript

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
