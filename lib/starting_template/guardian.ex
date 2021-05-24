defmodule StartingTemplate.Guardian do
  use Guardian, otp_app: :starting_template

  alias StartingTemplate.Accounts

  def subject_for_token(%{id: id} = _resource, _claims) do
    sub = to_string(id)
    {:ok, sub}
  end

  def subject_for_token(_, _) do
    {:error, :reason_for_error}
  end

  def resource_from_claims(%{"sub" => id} = _claims) do
    user = Accounts.get_user!(id)
    {:ok, user}
  end

  def resource_from_claims(_claims) do
    {:error, :reason_for_error}
  end

  # defp put_pass_hash(%Ecto.Changeset{valid?: true, changes: %{password: password}} = changeset) do
  #   change(changeset, add_hash(password))
  # end

  # defp put_pass_hash(changeset), do: changeset

  # defp password_changeset(user, attrs) do
  #   user
  #   |> cast(attrs, [:password])
  #   |> validate_required([:password])
  #   |> validate_length(:password, min: 8)
  #   |> put_pass_hash()
  #   |> validate_required([:password_hash])
  # end

  # def changeset(user, attrs \\ %{}) do
  #   user
  #   |> cast(attrs, [:username, :role_id])
  #   |> validate_required([:username, :role_id])
  #   |> password_changeset(attrs)
  # end
end
