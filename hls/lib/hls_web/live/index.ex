defmodule HlsWeb.Live.Index do
  use Phoenix.LiveView

  alias Hls.Chat
  alias Hls.Chat.Message

  def mount(session, socket) do
    if connected?(socket), do: Chat.subscribe(session.chat_id)
    {:ok, fetch(socket, session)}
  end

  def render(assigns) do
    HlsWeb.ChatView.render("index.html", assigns)
  end

  def fetch(socket, session \\ nil) do
    assign(socket, %{
      current_user: session.current_user.id,
      chat_id: session.chat_id,
      messages: Chat.get_messages(session.chat_id),
      changeset: Chat.change_message(%Message{user_id: session.current_user.id, chat_id: session.chat_id})
    })
  end

  def handle_event("validate", %{"message" => params}, socket) do
    changeset =
      %Message{}
      |> Chat.change_message(params)
      |> Map.put(:action, :insert)

    {:noreply, assign(socket, changeset: changeset)}
  end

  def handle_event("send_message", %{"message" => params}, socket) do
    case Chat.create_message(params) do
      {:ok, message} ->
        {:noreply, socket}

      {:error, %Ecto.Changeset{} = changeset} ->
        IO.puts "error"
        {:noreply, assign(socket, changeset: changeset)}
    end
  end

  def handle_info({Chat, [:message, _event_type], _message}, socket) do
    {:noreply, fetch(socket)}
  end
end

