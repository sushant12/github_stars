defmodule GithubStarsWeb.Router do
  use GithubStarsWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", GithubStarsWeb do
    pipe_through :browser

    get "/", HomeController, :index
    post "/", HomeController, :create
  end

  # Other scopes may use custom stacks.
  # scope "/api", GithubStarsWeb do
  #   pipe_through :api
  # end
end
