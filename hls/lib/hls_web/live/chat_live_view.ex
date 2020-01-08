defmodule HlsWeb.ChatLiveView do
  use Phoenix.LiveView
  alias Hls.Chats
  alias HlsWeb.Presence

  defp topic(chat_id), do: "chat:${chat_id}"

  def render(assigns) do
    HlsWeb.ChatView.render("show.html", assigns)
  end

  def mount(%{chat: chat, current_user: current_user}, socket) do
    # Presence.track_presence(
    #   self(),
    #   topic(chat.id),
    #   current_user.id,
    #   default_user_presence_payload(current_user)
    # )

    HlsWeb.Endpoint.subscribe(topic(chat.id))

    {:ok,
      assign(socket,
        chat: chat,
        message: Chats.change_message(),
        current_user: current_user,
        # users: Presence.list_presences(topic(chat.id)),
        # username_colors: username_colors(chat)
    )}
  end

  def handle_info(%{event: "message", payload: state}, socket) do
    {:noreply, assign(socket, state)}
  end

  def handle_event("message", %{"message" => message_params}, socket) do
    chat = Chats.create_message(message_params)
    {:noreply, assign(socket, chat: chat, message: Chats.change_message())}
  end
end