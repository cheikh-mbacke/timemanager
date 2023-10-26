defmodule EpietchWeb.ClockController do
  use EpietchWeb, :controller

  alias Epietch.Time.Clock
  alias Epietch.Repo
  import Ecto.Query

  def index(conn, %{"user_id" => user_id}) do
    query = from(c in Clock, where: c.user_id == ^user_id)
    clocks = Repo.all(query)
    json(conn, clocks)
  end

  def create(conn, clock_params) do
    changeset = Clock.changeset(%Clock{}, clock_params)

    case Repo.insert(changeset) do
      {:ok, clock} ->
        json(conn, %{status: "success", clock: clock})
    
      {:error, changeset} ->
        json(conn, %{status: "error", errors: changeset.errors})
    end
  end
end
