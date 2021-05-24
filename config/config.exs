# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :starting_template,
  ecto_repos: [StartingTemplate.Repo],
  generators: [binary_id: true]

# Configures the endpoint
config :starting_template, StartingTemplateWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "FLboUCaPxAxNKO/yEv9Q5lVr2/I+QcFT/j9BiixaCbyeuha5T0HAZIATE7iub+2h",
  render_errors: [view: StartingTemplateWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: StartingTemplate.PubSub,
  live_view: [signing_salt: "16hLL8uX"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :starting_template, StartingTemplate.Guardian,
  allowed_algos: ["HS512"],
  verify_module: Guardian.JWT,
  issuer: "StartingTemplate",
  ttl: {30, :days},
  allowed_drift: 2000,
  verify_issuer: true,
  secret_key: %{"k" => "YJTS-4nywpfKfZ9zeElGAA", "kty" => "oct"},
  serializer: StartingTemplate.Guardian

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
