defmodule GithubStarsWeb.StarredRepoController do
  use GithubStarsWeb, :controller
  alias GithubStars.{User, Repo, StarredRepo}

  def index(conn, params) do
    starred_repos =
      User.get_user_by_username(params["user"])
      |> StarredRepo.search_starred_repo(params["query"])

    render(conn, "index.html", starred_repos: starred_repos)
  end

  def update(conn, params) do
    user = User.get_user_by_username(params["user"])

    StarredRepo.owned_by(user.id, params["id"])
    |> case do
      {:ok, starred_repo} ->
        {:ok, updated_repo} =
          StarredRepo.update_starred_repo(starred_repo, %{tags: params["tags"]})

        tags =
          updated_repo.tags
          |> Enum.map_join(",", & &1.name)

        json(conn, %{success: true, message: "Tags saved successfully", tags: tags})

      {:error, msg} ->
        conn
        |> put_status(:not_found)
        |> json(%{success: false, message: msg})
    end
  end
end
