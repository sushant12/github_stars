defmodule Github do
  def fetch_starred_repos(user) do
    options = [ssl: [{:versions, [:"tlsv1.2"]}]]

    {:ok, %HTTPoison.Response{status_code: 200, body: body, headers: headers}} =
      HTTPoison.get("https://api.github.com/users/#{user.username}/starred", [], options)

    timestamp =
      NaiveDateTime.utc_now()
      |> NaiveDateTime.truncate(:second)

    {:ok, body} = Jason.decode(body)

    Enum.map(body, fn repo ->
      %{
        name: repo["name"],
        description: repo["description"],
        ref_id: repo["id"],
        github_url: repo["html_url"],
        language: repo["language"],
        user_id: user.id,
        inserted_at: timestamp,
        updated_at: timestamp
      }
    end)
    |> GithubStars.StarredRepo.create_starred_repos()

    # {"link", http_link_value} =
    #   Enum.find(headers, fn {key, value} -> http_link_header?(key, value) end)

    # {:ok, %ExLinkHeader{last: last}} = ExLinkHeader.parse(http_link_value)
    # last.params.page
  end

  def http_link_header?("link", _), do: true
  def http_link_header?(_, _), do: false
end
