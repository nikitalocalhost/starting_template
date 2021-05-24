defmodule StartingTemplate.Data do
  import Ecto.Query

  def data() do
    Dataloader.Ecto.new(StartingTemplate.Repo, query: &query/2)
  end

  def query(queryable, %{limit: query_limit} = params) do
    queryable
    |> limit(^query_limit)
    |> query(Map.drop(params, :limit))
  end

  def query(queryable, %{order_by: query_order_by} = params) do
    queryable
    |> order_by(^query_order_by)
    |> query(Map.drop(params, :order_by))
  end
end
