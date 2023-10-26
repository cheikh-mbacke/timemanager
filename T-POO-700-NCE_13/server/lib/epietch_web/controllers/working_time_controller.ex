defmodule EpietchWeb.WorkingTimeController do
  use EpietchWeb, :controller

  import Ecto.Query

  alias Epietch.Time.WorkingTime
  alias Epietch.Repo

  def index(conn, %{"user_id" => user_id, "start" => start, "end" => end_time}) when is_nil(start) or is_nil(end_time) do
    working_times = Repo.all(from wt in WorkingTime, where: wt.user_id == ^user_id)
    json(conn, working_times)
  end

  def index(conn, %{"user_id" => user_id, "start" => start, "end" => end_time}) do
    working_times = Repo.all(from wt in WorkingTime, where: wt.user_id == ^user_id and wt.start >= ^start and wt.end <= ^end_time)
    json(conn, working_times)
  end

  def show(conn, %{"id" => id}) do
    working_time = Repo.get(WorkingTime, id)
    case working_time do
      nil -> send_resp(conn, 404, "Working time not found")
      _ -> json(conn, working_time)
    end
  end

  def create(conn, %{"start" => start, "end" => end_time, "user_id" => user_id}) do
    params = %{"start" => start, "end" => end_time, "user_id" => user_id}
    changeset = WorkingTime.changeset(%WorkingTime{}, params)

    case Repo.insert(changeset) do
      {:ok, working_time} ->
        json(conn, %{status: "success", working_time: working_time})

      {:error, changeset} ->
        errors = Ecto.Changeset.traverse_errors(changeset, fn {msg, opts} ->
          Enum.reduce(opts, msg, fn {key, value}, acc ->
            String.replace(acc, "%{#{key}}", to_string(value))
          end)
        end)
        conn
        |> put_status(:unprocessable_entity)
        |> json(%{status: "error", errors: errors})
    end
  end

  def update(conn, %{"id" => id, "start" => start, "end" => end_time, "user_id" => user_id}) do
    params = %{"start" => start, "end" => end_time, "user_id" => user_id}
    working_time = Repo.get!(WorkingTime, id)
    changeset = WorkingTime.changeset(working_time, params)

    case Repo.update(changeset) do
      {:ok, working_time} ->
        json(conn, %{status: "success", working_time: working_time})

      {:error, changeset} ->
        errors = Ecto.Changeset.traverse_errors(changeset, fn {msg, opts} ->
          Enum.reduce(opts, msg, fn {key, value}, acc ->
            String.replace(acc, "%{#{key}}", to_string(value))
          end)
        end)
        conn
        |> put_status(:unprocessable_entity)
        |> json(%{status: "error", errors: errors})
    end
  end

  def delete(conn, %{"id" => id}) do
    working_time = Repo.get!(WorkingTime, id)

    case Repo.delete(working_time) do
      {:ok, _} ->
        json(conn, %{status: "success"})

      {:error, _} ->
        json(conn, %{status: "error", message: "Failed to delete working time"})
    end
  end
end
