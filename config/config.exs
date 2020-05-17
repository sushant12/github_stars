# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :github_stars,
  ecto_repos: [GithubStars.Repo]

# Configures the endpoint
config :github_stars, GithubStarsWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "MMExvUgbAxipxs4cC4in1eVCVGSGHw1FP4Z8lzbB1nxI8OOL5wPKevheTS1ulTyB",
  render_errors: [view: GithubStarsWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: GithubStars.PubSub, adapter: Phoenix.PubSub.PG2],
  live_view: [signing_salt: "f6gv2mdz"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
