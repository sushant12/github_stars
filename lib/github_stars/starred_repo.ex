defmodule GithubStars.StarredRepo do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query, only: [from: 2]

  alias GithubStars.{Repo, Tag, User, StarredRepo, StarredRepoTag}

  schema "starred_repos" do
    field :description, :string
    field :github_url, :string
    field :name, :string
    field :ref_id, :integer
    field :language, :string

    belongs_to :user, User

    many_to_many :tags, Tag,
      join_through: "starred_repo_tags",
      on_delete: :delete_all,
      on_replace: :delete

    timestamps()
  end

  @doc false
  def changeset(starred_repo, attrs) do
    starred_repo
    |> cast(attrs, [:name, :description, :ref_id, :github_url, :language, :user_id])
    |> foreign_key_constraint(:user_id)
    |> unique_constraint([:ref_id, :user_id])
    |> put_assoc(:tags, parse_tags(attrs))
  end

  def create_starred_repo(attrs) do
    %__MODULE__{}
    |> changeset(attrs)
    |> Repo.insert(
      on_conflict: :replace_all,
      conflict_target: [:user_id, :ref_id]
    )
  end

  def create_starred_repos(attrs) do
    Repo.insert_all(__MODULE__, attrs,
      on_conflict: {:replace_all_except, [:id]},
      conflict_target: [:user_id, :ref_id]
    )
  end

  def update_starred_repo(starred_repo, attrs) do
    starred_repo
    |> Repo.preload(:tags)
    |> changeset(attrs)
    |> Repo.update()
  end

  def get_starred_repo(user) do
    user
    |> Ecto.assoc(:starred_repos)
    |> Repo.all()
    |> Repo.preload(:tags)
  end

  def search_starred_repo(user, ""), do: get_starred_repo(user)

  def search_starred_repo(user, tag) do
    query =
      from s in StarredRepo,
        join: t in assoc(s, :tags),
        join: u in assoc(s, :user),
        where: u.username == ^user.username and ilike(t.name, ^"%#{tag}%"),
        distinct: true

    Repo.all(query) |> Repo.preload(:tags)
  end

  def owned_by(user_id, starred_repo_id) do
    query = from s in __MODULE__, where: s.user_id == ^user_id and s.id == ^starred_repo_id

    case Repo.one(query) do
      starred_repo = %GithubStars.StarredRepo{} ->
        {:ok, starred_repo}

      nil ->
        {:error, "Could not find the starred repo"}
    end
  end

  def build_starred_repos(
        {:ok, %HTTPoison.Response{status_code: 200, body: body, headers: headers}},
        user
      ) do
    timestamp =
      NaiveDateTime.utc_now()
      |> NaiveDateTime.truncate(:second)

    {:ok, body} = Jason.decode(body)

    Enum.map(body, fn repo ->
      %{
        name: repo["name"],
        description: repo["description"],
        ref_id: repo["id"],
        github_url: repo["html_url"],
        language: repo["language"],
        user_id: user.id,
        inserted_at: timestamp,
        updated_at: timestamp
      }
    end)
  end

  defp parse_tags(attrs) do
    (attrs[:tags] || "")
    |> String.split(",")
    |> Enum.map(&String.trim/1)
    |> Enum.reject(&(&1 == ""))
    |> insert_and_get_all
  end

  defp insert_and_get_all([]), do: []

  defp insert_and_get_all(names) do
    timestamp =
      NaiveDateTime.utc_now()
      |> NaiveDateTime.truncate(:second)

    maps =
      Enum.map(
        names,
        &%{
          name: &1,
          inserted_at: timestamp,
          updated_at: timestamp
        }
      )

    Repo.insert_all(Tag, maps, on_conflict: :nothing)
    Repo.all(from t in Tag, where: t.name in ^names)
  end
end
