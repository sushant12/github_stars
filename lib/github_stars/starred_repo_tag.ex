defmodule GithubStars.StarredRepoTag do
  use Ecto.Schema
  import Ecto.Changeset
  alias GithubStars.{StarredRepo, Tag}

  schema "starred_repo_tags" do
    belongs_to :starred_repo, StarredRepo
    belongs_to :tag, Tag
    timestamps()
  end

  @doc false
  def changeset(starred_repo_tag, attrs) do
    starred_repo_tag
    |> cast(attrs, [:starred_repo_id, :tag_id])
    |> foreign_key_constraint(:starred_repo_id)
    |> foreign_key_constraint(:tag_id)
  end
end
