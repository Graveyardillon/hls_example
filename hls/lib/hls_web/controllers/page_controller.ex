defmodule HlsWeb.PageController do
  use HlsWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
