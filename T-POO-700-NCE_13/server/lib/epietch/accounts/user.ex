defmodule Epietch.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset

  @derive {Jason.Encoder, only: [:id, :username, :email, :inserted_at, :updated_at]}
  schema "users" do
    field :username, :string
    field :email, :string
    has_many :clocks, Epietch.Time.Clock
    has_many :working_times, Epietch.Time.WorkingTime

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:username, :email])
    |> validate_required([:username, :email])
    |> validate_format(:email, ~r/^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,4}$/)
    |> unique_constraint(:email)
  end
end
