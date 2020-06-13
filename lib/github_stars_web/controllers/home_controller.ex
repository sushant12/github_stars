defmodule GithubStarsWeb.HomeController do
  use GithubStarsWeb, :controller
  alias GithubStars.{User, StarredRepo}

  def index(conn, _params) do
    changeset = User.changeset(%User{})
    render(conn, "index.html", changeset: changeset)
  end

  def create(conn, %{"user" => params}) do
    user = User.create_user(params)

    Github.fetch_starred_repos(user)
    |> StarredRepo.build_starred_repos(user)
    |> StarredRepo.create_starred_repos()

    redirect(conn, to: Routes.starred_repo_path(conn, :index, user.username))
  end
end
