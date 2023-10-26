defmodule Epietch.Repo do
  use Ecto.Repo,
    otp_app: :epietch,
    adapter: Ecto.Adapters.Postgres
end
