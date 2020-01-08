defmodule Hls.Chats.Chat do
  use Ecto.Schema
  import Ecto.Changeset
  alias Hls.Chats.Message
  alias Hls.Accounts.User

  schema "chats" do
    has_many :messages, Message
    belongs_to :user, User
    # field :user_id, :id
    timestamps()
  end

  @doc false
  # def changeset(chat, attrs) do
  def changeset(chat, params \\ %{}) do
    chat
    |> cast(params, [:user_id])
    |> validate_required([:user_id])
  end
end
