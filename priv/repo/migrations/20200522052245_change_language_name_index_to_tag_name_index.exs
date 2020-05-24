defmodule GithubStars.Repo.Migrations.ChangeLanguageNameIndexToTagNameIndex do
  use Ecto.Migration

  def change do
    execute("ALTER INDEX languages_name_index RENAME TO tags_name_index")
  end
end
