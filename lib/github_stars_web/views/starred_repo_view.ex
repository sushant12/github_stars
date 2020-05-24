defmodule GithubStarsWeb.StarredRepoView do
  use GithubStarsWeb, :view

  def parse_tags(tags) do
    tags
    |> Enum.map_join(", ", & &1.name)
  end
end
