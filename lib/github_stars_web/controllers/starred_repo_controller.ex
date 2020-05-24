defmodule GithubStarsWeb.StarredRepoController do
  use GithubStarsWeb, :controller
  alias GithubStars.{User, Repo, StarredRepo}

  def index(conn, params) do
    starred_repos =
      User.get_user_by_username(params["user"])
      |> StarredRepo.get_starred_repo()

    render(conn, "index.html", starred_repos: starred_repos)
  end
end
