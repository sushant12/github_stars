defmodule GithubStars.Repo.Migrations.AlterTagsComment do
  use Ecto.Migration

  def change do
    alter table("tags", comment: "Tags of all the repos") do
      modify :name, :string, comment: "Tags to define a repo"
    end
  end
end
