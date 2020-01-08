defmodule HlsWeb.ChatController do
  use HlsWeb, :controller
  alias Hls.Chats
  alias Hls.Accounts
  alias Phoenix.LiveView
  alias HlsWeb.ChatLiveView

  plug :is_authorized when action in [:new, :show]

  def new(conn, %{"id" => id}) do
    user_id = %{user_id: id}
    Chats.create_chat(user_id)
    current_user = Accounts.current_user(conn)
  end

  def index(conn, _params) do
    chats = Chats.list_chats()
    render(conn, "index.html", chats: chats)
  end

  def show(conn, %{"id" => chat_id}) do
    chat = Chats.get_chat(chat_id)

    LiveView.Controller.live_render(
      conn,
      ChatLiveView,
      session: %{chat: chat, current_user: conn.assigns.current_user}
    )
  end

  defp is_authorized(conn, _) do
    current_user = Accounts.current_user(conn)
    if current_user.id == String.to_integer(conn.params["id"]) do
      assign(conn, :current_user, current_user)
    else
      conn
      |> put_flash(:error, "You can't modify.")
      |> redirect(to: Routes.page_path(conn, :index))
      |> halt()
    end
  end
end
