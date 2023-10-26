defmodule EpietchWeb.UserController do
  use EpietchWeb, :controller

  import Ecto.Query, warn: false

  alias Epietch.Repo
  alias Epietch.Accounts.User

  def index(conn, params) do
    query = from(u in User)

    query =
      case params["email"] do
        nil -> query
        email -> query |> where([u], u.email == ^email)
      end

    query =
      case params["username"] do
        nil -> query
        username -> query |> where([u], u.username == ^username)
      end

    users = Repo.all(query)

    json(conn, users)
  end

  # Affiche un utilisateur spécifique par ID
  def show(conn, %{"user_id" => user_id}) do
     IO.inspect("TOTOTOTOTOTTOTOT")

    IO.inspect("user: " <> inspect(user_id))

    user = Repo.get(User, user_id)


    case user do
      nil -> send_resp(conn, 404, "User not found")
      _ -> json(conn, user)
    end
  end

  # Crée un nouvel utilisateur
  @spec create(
          Plug.Conn.t(),
          :invalid | %{optional(:__struct__) => none(), optional(atom() | binary()) => any()}
        ) :: Plug.Conn.t()
  def create(conn, user_params) do
    IO.inspect("user_params: " <> inspect(user_params))

    changeset = User.changeset(%User{}, user_params)

    IO.inspect("changeset: " <> inspect(changeset))

    case Repo.insert(changeset) do
      {:ok, user} ->
        json(conn, user)

      {:error, changeset} ->
        errors =
          Ecto.Changeset.traverse_errors(changeset, fn {msg, opts} ->
            Enum.reduce(opts, msg, fn {key, value}, acc ->
              String.replace(acc, "%{#{key}}", to_string(value))
            end)
          end)

        conn
        |> put_status(:unprocessable_entity)
        |> json(%{errors: errors})
    end
  end

  # Met à jour un utilisateur spécifique par ID
  def update(conn, %{"user_id" => user_id} = user_params) do
    user = Repo.get(User, user_id)

    case user do
      nil ->
        send_resp(conn, 404, "User not found")

      _ ->
        changeset = User.changeset(user, user_params)

        case Repo.update(changeset) do
          {:ok, user} ->
            json(conn, user)

          {:error, changeset} ->
            errors =
              Ecto.Changeset.traverse_errors(changeset, fn {msg, opts} ->
                Enum.reduce(opts, msg, fn {key, value}, acc ->
                  String.replace(acc, "%{#{key}}", to_string(value))
                end)
              end)

            conn
            |> put_status(:unprocessable_entity)
            |> json(%{errors: errors})
        end
    end
  end

  # Supprime un utilisateur spécifique par ID
  def delete(conn, %{"user_id" => user_id}) do
    user = Repo.get(User, user_id)

    case user do
      nil ->
        send_resp(conn, 404, "User not found")

      _ ->
        {:ok, _} = Repo.delete(user)
        send_resp(conn, 200, "User deleted")
    end
  end
end
