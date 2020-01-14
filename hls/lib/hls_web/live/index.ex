defmodule HlsWeb.Live.Index do
  use Phoenix.LiveView

  alias Hls.Chat
  alias Hls.Chat.Message

  def mount(session, socket) do
    chat_id = session.chat_id
    current_user = session.current_user
    if connected?(socket), do: Chat.subscribe(chat_id)
    {:ok, fetch(socket, chat_id, current_user)}
  end

  def render(assigns) do
    HlsWeb.ChatView.render("index.html", assigns)
  end

  def fetch(socket, chat_id, current_user \\ nil) do
    assign(socket, %{
      current_user: current_user.id,
      chat_id: chat_id,
      user_name: current_user.name,
      messages: Chat.get_messages(chat_id),
      changeset: Chat.change_message(%Message{user_id: current_user.id, chat_id: chat_id})
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
    IO.inspect(params)
    case Chat.create_message(params) do
      {:ok, message} ->
        {:noreply, fetch(socket, message)}
        # {:noreply, fetch(socket, message.user_id)}

      {:error, %Ecto.Changeset{} = changeset} ->
        IO.puts "error"
        {:noreply, assign(socket, changeset: changeset)}
    end
  end

  def handle_info({Chat, [:message, _event_type], _message}, socket) do
    {:noreply, fetch(socket, get_user_name(socket))}
  end

  defp get_user_name(socket) do
    socket.assigns
    |> Map.get(:user_id)
  end
end