defmodule GithubStars.Repo.Migrations.CreateStarredRepos do
  use Ecto.Migration

  def change do
    create table(:starred_repos, comment: "Starred Repos of users") do
      add :name, :string, comment: "name of the repo"
      add :description, :string, comment: "description of the repo"
      add :ref_id, :string, comment: "unique id of the repo"
      add :github_url, :string , comment: "github link of the repo"

      timestamps()
    end

  end
end
