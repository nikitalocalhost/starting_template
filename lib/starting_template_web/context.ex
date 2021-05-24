defmodule StartingTemplateWeb.Context do
  @behaviour Plug

  import Plug.Conn

  alias StartingTemplate.Guardian

  alias StartingTemplate.Accounts

  def init(opts), do: opts

  def call(conn, _) do
    case build_context(conn) do
      {:ok, context} -> put_private(conn, :absinthe, %{context: context})
      _ -> conn
    end
  end

  defp build_context(conn) do
    with ["Bearer " <> token] <- get_req_header(conn, "authorization"),
         {:ok, current_user} <- authorize(token) do
      {:ok, %{current_user: current_user, token: token}}
    end
  end

  defp authorize(token) do
    IO.inspect(token)

    with {:ok, claims} <- Guardian.decode_and_verify(token),
         {:ok, user} <- Accounts.get_user(claims["sub"]) do
      {:ok, user}
    end
  end
end
