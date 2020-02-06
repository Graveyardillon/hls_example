defmodule Hls.Chat do
  @moduledoc """
  The Chat context.
  """

  import Ecto.Query, warn: false
  alias Hls.Repo
  alias Hls.Accounts.User

  alias Hls.Chat.Message

  def subscribe(chat_id) do
    Phoenix.PubSub.subscribe(Hls.PubSub, chat_id)
  end

  # def create_message(chat_id, current_user, attrs) do
  #   %Message{}
  #   |> Message.changeset(attrs)
  #   |> Repo.insert()
  #   # |> notify_subs(chat_id, [:message, :inserted])
  #   |> notify_subs(chat_id, current_user, [:message, :inserted])
  # end

  def change_message(%Message{} = message, attrs \\ %{}) do
    Message.changeset(message, attrs)
  end

  def get_messages(chat_id) do
    from(c in Message,
      where: c.chat_id == ^chat_id,
      order_by: [asc: c.inserted_at],
      limit: 100,
      preload: [:user]
    )
    |> Repo.all()
  end

  def create_message(chat_id, user_id, attrs) do
    %Message{chat_id: chat_id, user_id: user_id}
    |> Message.changeset(attrs)
    |> Repo.insert
  end

  def preload(%Message{} = message, opts) do
    Repo.preload(message, opts)
  end
end
