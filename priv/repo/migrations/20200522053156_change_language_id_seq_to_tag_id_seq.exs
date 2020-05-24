defmodule GithubStars.Repo.Migrations.ChangeLanguageIdSeqToTagIdSeq do
  use Ecto.Migration

  def change do
    execute("ALTER SEQUENCE languages_id_seq RENAME TO tags_id_seq")
  end
end
