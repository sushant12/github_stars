defmodule GithubStarsWeb.HomeController do
  use GithubStarsWeb, :controller
  alias GithubStars.{User, Repo}

  def index(conn, _params) do
    changeset = User.changeset(%User{})
    render(conn, "index.html", changeset: changeset)
  end

  def create(conn, params) do
    %User{}
    |> User.changeset(params)
    |> Repo.insert()
  end
end
