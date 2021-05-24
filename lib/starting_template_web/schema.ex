defmodule StartingTemplateWeb.Schema do
  use Absinthe.Schema
  import Absinthe.Resolution.Helpers, only: [dataloader: 1]

  import Ecto.Query

  alias StartingTemplate.Repo

  alias StartingTemplate.Accounts

  alias StartingTemplate.Data

  def context(ctx) do
    loader =
      Dataloader.new()
      |> Dataloader.add_source(Repo, Data.data())

    Map.put(ctx, :loader, loader)
  end

  def plugins do
    [Absinthe.Middleware.Dataloader] ++ Absinthe.Plugin.defaults()
  end

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

    field :me, :user do
      resolve(&Accounts.resolve_me/2)
    end

    field :users, list_of(:user) do
      arg(:ids, list_of(:id))
      arg(:limit, :integer)
      arg(:order_by, :string)

      resolve(fn args, _context ->
        query = from(Accounts.User)

        query =
          Enum.reduce(args, query, fn {field, value}, query ->
            case field do
              :ids -> where(query, [p], p.id in ^value)
              :limit -> limit(query, ^value)
              :order_by -> order_by(query, asc: ^String.to_atom(value))
            end
          end)

        {:ok, Repo.all(query)}
      end)
    end
  end
end
