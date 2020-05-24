defmodule GithubStars.Repo.Migrations.DropStarredRepoLanguage do
  use Ecto.Migration

  def change do
    drop table("starred_repo_languages")
  end
end
