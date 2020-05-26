alias GithubStars.{
  User,
  Repo,
  StarredRepoTag,
  StarredRepo,
  Tag
}

IO.puts("====================creating user ")
user = User.create_user(%{"username" => "demouser4"})

IO.puts("====================creating repos ")

starred_repos =
  Ecto.build_assoc(user, :starred_repos, %{
    ref_id: 85_487_665,
    name: "exaws",
    description: "api for aws",
    github_url: "http://www.github.com",
    language: "elixir"
  })

Repo.insert!(starred_repos)

# IO.puts("====================creating user ")
# user = User.create_user(%{username: "demouser6"})

# timestamp =
#   NaiveDateTime.utc_now()
#   |> NaiveDateTime.truncate(:second)

# IO.puts("====================creating repos ")

# starred_repos = [
#   %{
#     ref_id: "123",
#     name: "exaws",
#     description: "api for aws",
#     github_url: "http://www.github.com",
#     language: "elixir",
#     user_id: user.id,
#     inserted_at: timestamp,
#     updated_at: timestamp
#   },
#   %{
#     ref_id: "1243",
#     name: "catarse",
#     description: "crowdfunding website",
#     github_url: "http://www.github.com",
#     language: "ruby",
#     user_id: user.id,
#     inserted_at: timestamp,
#     updated_at: timestamp
#   }
# ]

# Repo.insert_all(StarredRepo, starred_repos)

# timestamp =
#   NaiveDateTime.utc_now()
#   |> NaiveDateTime.truncate(:second)

# tags = [
#   %{name: "devops", inserted_at: timestamp, updated_at: timestamp},
#   %{name: "utilities", inserted_at: timestamp, updated_at: timestamp},
#   %{name: "frontend", inserted_at: timestamp, updated_at: timestamp}
# ]

# IO.puts("====================creating tags ")

# Repo.insert_all(Tag, tags)
