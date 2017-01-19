defmodule Web.Router do
  use Web.Web, :router

  pipeline(:browser) do
    plug(:accepts, ["html"])
    plug(:fetch_session)
    plug(:fetch_flash)
    plug(:protect_from_forgery)
    plug(:put_secure_browser_headers)
  end

  scope("/", Web) do
    pipe_through(:browser)
    get("/", PageController, :index)
  end

  pipeline(:api) do
    plug(:accepts, ["json"])
  end

  scope("/api", Web) do
    pipe_through(:api)
    get("/graph", PageController, :get_graph)
  end
end
