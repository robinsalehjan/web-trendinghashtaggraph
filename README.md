# TrendingHashtagGraph
[![Build Status](https://travis-ci.org/robinsjdotcom/TrendingHashtagGraph.svg?branch=master)](https://travis-ci.org/robinsjdotcom/TrendingHashtagGraph)
[![Deps Status](https://beta.hexfaktor.org/badge/all/github/robinsjdotcom/TrendingHashtagGraph.svg)](https://beta.hexfaktor.org/github/robinsjdotcom/TrendingHashtagGraph)

See the most trending hashtags on Twitter and see how they are related to other tweets or hashtags.

URL: https://trendinghashtaggraph.herokuapp.com

JSON: https://trendinghashtaggraph.herokuapp.com/api/graph

![ScreenShot](https://github.com/robinsjdotcom/TrendingHashtagGraph/blob/master/Screenshot.png)

# Blog posts
[Checklist for deploying umbrella applications to Heroku](https://medium.com/@robinsjdotcom/checklist-for-deploying-umbrella-applications-to-heroku-74a79e07e21f#.qspvspxt4) - While trying to deploy this umbrella application to Heroku, I often found inconsistent resources. Therefore I made this post for the proper configuration on how to do so.

[Periodic scheduling using a GenServer](https://medium.com/@robinsjdotcom/periodic-scheduling-using-a-genserver-33242b439bc4#.1d2ahei60) - This is often asked and pondered about from people just starting with Elixir. In the post I detail one caveat of doing so and how to avoid it, as well as a implementation for the better ways of doing so.

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
