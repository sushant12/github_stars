defmodule GithubStars.Repo.Migrations.AddUniqueConstraintToStarredRepo do
  use Ecto.Migration
  @disable_ddl_transaction true
  @disable_migration_lock true

  def up do
    create unique_index("starred_repos", [:ref_id, :user_id], concurrently: true)
  end

  def down do
    drop index("starred_repos", [:ref_id, :user_id])
  end
end
