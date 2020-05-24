defmodule GithubStars.Repo.Migrations.CreateStarredRepoTags do
  use Ecto.Migration

  def change do
    create table(:starred_repo_tags, comment: "Join table for starred repo and tags") do
      add :starred_repo_id, references("starred_repos", on_delete: :delete_all)
      add :tag_id, references("tags", on_delete: :delete_all)
    end

    create unique_index(:starred_repo_tags, [:starred_repo_id, :tag_id])
  end
end
