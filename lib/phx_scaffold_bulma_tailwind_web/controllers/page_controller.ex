defmodule PhxScaffoldBulmaTailwindWeb.PageController do
  use PhxScaffoldBulmaTailwindWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end

  def tailwind(conn, _params) do
    render(conn, "tailwind.html")
  end
end
