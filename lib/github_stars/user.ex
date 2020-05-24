defmodule GithubStars.User do
  use Ecto.Schema
  import Ecto.Changeset

  alias GithubStars.{Repo, StarredRepo}

  schema "users" do
    field :username, :string
    has_many(:starred_repos, StarredRepo)
    timestamps()
  end

  @doc false
  def changeset(user, attrs \\ %{}) do
    user
    |> cast(attrs, [:username])
    |> validate_required([:username])
    |> unique_constraint(:username)
  end

  def create_user(attrs) do
    %__MODULE__{}
    |> changeset(attrs)
    |> Repo.insert()
  end

  def get_user_by_username(username), do: Repo.get_by(__MODULE__, username: username)
end
