defmodule StartingTemplateWeb.Schema do
  use Absinthe.Schema

  alias StartingTemplate.Accounts

  @items %{
    "1" => %{id: "1"},
    "2" => %{id: "2"}
  }

  object :user do
    field :id, :id
    field :username, :string
  end

  object :session do
    field :token, :string
  end

  object :item do
    field :id, :id
  end

  query do
    field :login, :session do
      arg(:username, non_null(:string))
      arg(:password, non_null(:string))

      resolve(&StartingTemplate.Accounts.login/2)
    end

    field :item, :item do
      arg(:id, non_null(:id))

      resolve(fn %{id: item_id}, _ ->
        {:ok, @items[item_id]}
      end)
    end

    field :me, :user do
      resolve(&Accounts.resolve_me/2)
    end
  end
end
