defmodule HlsWeb.LayoutView do
  use HlsWeb, :view

  alias Hls.Accounts.Guardian

  def current_user(conn) do
    Guardian.Plug.current_resource(conn)
  end
end
