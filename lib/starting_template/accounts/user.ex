defmodule StartingTemplate.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset

  import Argon2, only: [add_hash: 1]

  @roles ~w[USER MODERATOR ADMIN]

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "users" do
    field :username, :string
    field :role, :string
    field :password, :string, virtual: true
    field :password_hash, :string

    timestamps()
  end

  defp put_pass_hash(%Ecto.Changeset{valid?: true, changes: %{password: password}} = changeset) do
    change(changeset, add_hash(password))
  end

  defp put_pass_hash(changeset), do: changeset

  defp password_changeset(user, attrs) do
    user
    |> cast(attrs, [:password])
    |> validate_required([:password])
    |> validate_length(:password, min: 8)
    |> put_pass_hash()
    |> validate_required([:password_hash])
  end

  defp role_changeset(user, attrs) do
    user
    |> cast(attrs, [:role])
    |> validate_required([:role])
    |> validate_inclusion(:role, @roles)
  end

  def changeset(user, attrs \\ %{}) do
    user
    |> cast(attrs, [:username])
    |> validate_required([:username])
    |> password_changeset(attrs)
    |> role_changeset(attrs)
  end

  def check_pass(user, pass) do
    cond do
      Argon2.check_pass(user, pass) -> {:ok, user}
      true -> {:error, "Incorrect login credentials"}
    end
  end
end
