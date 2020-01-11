defmodule Hls.Chats do
  import Ecto.Query

  alias Hls.Chats.Chat
  alias Hls.Repo

  # def create_chat(chat_params) do
  #   Chat.changeset(%Chat{}, chat_params)
  #   |> Repo.insert()
  # end

  def create_msg(msg_params) do
    Chat.changeset(%Chat{}, msg_params)
    |> Repo.insert()

    Hls.Chats.get_chat(msg_params["board_user_id"])
  end

  def change_msg do
    Chat.changeset(%Chat{})
  end

  def change_msg(changeset, changes) do
    Chat.changeset(changeset, changes)
  end

  def list_chats do
    Repo.all(Chat)
  end

  def get_chat(board_user_id) do
    query =
      from c in Chat,
      where: c.board_user_id == ^board_user_id
      # preload: [messages: :user]

    Repo.all(query)
  end
end
