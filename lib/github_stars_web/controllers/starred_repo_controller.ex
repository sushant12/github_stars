defmodule GithubStarsWeb.StarredRepoController do
  use GithubStarsWeb, :controller
  alias GithubStars.{User, Repo, StarredRepo}

  def index(conn, params) do
    starred_repos =
      User.get_user_by_username(params["user"])
      |> StarredRepo.get_starred_repo()

    render(conn, "index.html", starred_repos: starred_repos)
  end

  def update(conn, params) do
    user = User.get_user_by_username(params["user"])

    StarredRepo.owned_by(user.id, params["id"])
    |> case do
      {:ok, starred_repo} ->
        StarredRepo.update_starred_repo(starred_repo, %{tags: params["tags"]})
        json(conn, %{success: true, message: "Tags saved successfully"})

      {:error, msg} ->
        conn
        |> put_status(:not_found)
        |> json(%{success: false, message: msg})
    end
  end
end
