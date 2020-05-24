defmodule GithubStars.Repo.Migrations.CreateStarredRepoLanguage do
  use Ecto.Migration

  def change do
    create table(:starred_repo_languages, comment: "Join table for starred repo and language") do
      add :starred_repo_id, references("starred_repos", on_delete: :delete_all)
      add :language_id, references("languages", on_delete: :delete_all)
    end

    create unique_index(:starred_repo_languages, [:starred_repo_id, :language_id])
  end
end
