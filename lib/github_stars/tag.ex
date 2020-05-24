defmodule GithubStars.Tag do
  use Ecto.Schema
  import Ecto.Changeset

  alias GithubStars.{StarredRepo, Repo}

  schema "tags" do
    field :name, :string

    many_to_many :starred_repos, StarredRepo,
      join_through: "starred_repo_tags",
      on_delete: :delete_all

    timestamps()
  end

  @doc false
  def changeset(tag, attrs) do
    tag
    |> cast(attrs, [:name])
    |> validate_required([:name])
    |> unique_constraint(:name)
  end

  def create_tag(attrs) do
    %__MODULE__{}
    |> changeset(attrs)
    |> Repo.insert()
  end
end
