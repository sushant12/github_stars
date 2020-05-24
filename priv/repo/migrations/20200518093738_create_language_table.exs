defmodule GithubStars.Repo.Migrations.CreateLanguageTable do
  use Ecto.Migration

  def change do
    create table(:languages, comment: "List of programming languages") do
      add :name, :string, comment: "Programming language used"

      timestamps()
    end
    create unique_index(:languages, [:name])
  end
end
