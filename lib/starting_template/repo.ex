defmodule StartingTemplate.Repo do
  use Ecto.Repo,
    otp_app: :starting_template,
    adapter: Ecto.Adapters.Postgres
end
