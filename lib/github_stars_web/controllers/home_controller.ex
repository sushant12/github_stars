defmodule GithubStarsWeb.HomeController do
  use GithubStarsWeb, :controller
  alias GithubStars.{User, Repo}

  def index(conn, _params) do
    changeset = User.changeset(%User{})
    render(conn, "index.html", changeset: changeset)
  end

  def create(conn, %{"user" => params}) do
    User.create_user(params)
    |> case do
      {:ok, user} ->
        redirect(conn, to: Routes.starred_repo_path(conn, :index, user.username))

      {:error, changeset} ->
        conn
        |> put_flash(:error, "username is already taken")
        |> redirect(to: Routes.home_path(conn, :index))
    end

    # username = params["user"]["username"]

    # {:ok, resp} = HTTPoison.get("https://api.github.com/users/#{username}/starred")
    # {"link", str} = Enum.find(resp.headers, fn {h, v} -> h == "link" end)
    # {:ok, parsed} = ExLinkHeader.parse(str)

    # Enum.each(
    #   2..String.to_integer(parsed.last.params.page),
    #   &spawn(fn ->
    #     IO.inspect(HTTPoison.get("https://api.github.com/users/#{username}/starred?page=#{&1}"))
    #   end)
    # )

    # redirect(conn, to: Routes.starred_repo_path(conn, :index))
  end
end
