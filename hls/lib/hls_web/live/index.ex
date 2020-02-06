defmodule HlsWeb.Live.Index do
  use Phoenix.LiveView

  alias Hls.Chat
  alias Hls.Chat.Message

  alias HlsWeb.Endpoint

  def mount(
    _params,
    %{"chat_id" => chat_id, "current_user" => current_user} = _session,
    socket
  ) do
    Chat.subscribe(chat_id)
    {:ok,
      assign(socket,
        current_user: current_user,
        chat_id: chat_id,
        messages: Chat.get_messages(chat_id),
        changeset: Chat.change_message(%Message{user_id: current_user.id, chat_id: chat_id})
      )
    }
  end

  defp topic(chat_id), do: "room:#{chat_id}"

  def render(assigns) do
    HlsWeb.ChatView.render("index.html", assigns)
  end

  def handle_event("validate", %{"message" => params}, socket) do
    changeset =
      %Message{}
      |> Chat.change_message(params)
      |> Map.put(:action, :insert)

    {:noreply, assign(socket, changeset: changeset)}
  end

  def handle_event(
    "send_message",
    %{"message" => message} = _payload,
    %{assigns: %{chat_id: chat_id, current_user: current_user}} = socket
    ) do
    IO.inspect(chat_id)
    IO.inspect(current_user.id)
    case Chat.create_message(message, chat_id, current_user) do
      {:ok, message} ->
        Endpoint.broadcast!(
          topic(chat_id), "new_message", Chat.preload(message, :user)
        )
        {:noreply, socket}

      {:error, %Ecto.Changeset{} = changeset} ->
        IO.puts "error"
        {:noreply, assign(socket, changeset: changeset)}
    end
  end

  def handle_info({Chat, [:message, _event_type], _message}, socket) do
    {:noreply, socket}
  end
end

