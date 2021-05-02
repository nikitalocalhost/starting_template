defmodule StartingTemplateWeb.PageController do
  use StartingTemplateWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
