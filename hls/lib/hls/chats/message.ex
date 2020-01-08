defmodule Hls.Chats.Message do
  use Ecto.Schema
  import Ecto.Changeset
  alias Hls.Chats.Chat
  alias Hls.Accounts.User

  schema "messages" do
    belongs_to :chat, Chat
    belongs_to :user, User
    field :msg, :string

    timestamps()
  end

  @doc false
  def changeset(message, attrs) do
    message
    |> cast(attrs, [:msg, :user_id, :chat_id])
    |> validate_required([:msg, :user_id, :chat_id])
  end
end
