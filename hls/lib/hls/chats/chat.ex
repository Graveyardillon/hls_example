defmodule Hls.Chats.Chat do
  use Ecto.Schema
  import Ecto.Changeset
  alias Hls.Chats.Message

  schema "chats" do
    has_many :messages, Message
    field :user_id, :id
    timestamps()
  end

  @doc false
  def changeset(chat, attrs) do
    chat
    |> cast(attrs, [])
    |> validate_required([])
  end
end
