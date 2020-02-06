defmodule HlsWeb.ChatController do
  use HlsWeb, :controller
  alias Hls.Accounts
  use Phoenix.LiveView

  def index(conn, %{"user_id" => chat_id}) do
    Phoenix.LiveView.Controller.live_render(
      conn,
      HlsWeb.Live.Index,
      session: %{chat_id: chat_id, current_user: Accounts.current_user(conn)}
    )
  end
end