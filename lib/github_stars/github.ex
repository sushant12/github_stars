defmodule Github do
  def fetch_starred_repos(user) do
    options = [ssl: [{:versions, [:"tlsv1.2"]}]]
    HTTPoison.get("https://api.github.com/users/#{user.username}/starred", [], options)
  end
end
