defmodule GithubStars.Repo.Migrations.ChangeLangaugesToTags do
  use Ecto.Migration

  def change do
    rename table("languages"), to: table("tags")
  end
end
