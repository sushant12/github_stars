defmodule GithubStars.Repo.Migrations.ChangeRefId do
  use Ecto.Migration

  def change do
    execute(&execute_up/0, &execute_down/0)
  end

  defp execute_up do
    repo().query("ALTER TABLE starred_repos ALTER COLUMN ref_id TYPE integer USING (ref_id::integer)")
  end

  defp execute_down do
    repo().query("ALTER TABLE starred_repos ALTER COLUMN ref_id TYPE varying(255)")
  end
end
