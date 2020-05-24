defmodule GithubStars.Repo.Migrations.AddLanguageToStarredRepo do
  use Ecto.Migration

  def change do
    alter table("starred_repos") do
      add :language, :string, comment: "Programming language used"
    end
  end
end
