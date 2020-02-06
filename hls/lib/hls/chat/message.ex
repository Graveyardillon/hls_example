defmodule Hls.Chat.Message do
  use Ecto.Schema
  import Ecto.Changeset
  alias Hls.Accounts.User

  schema "messages" do
    field :chat_id, :integer
    field :msg, :string
    belongs_to :user, User

    timestamps()
  end

  @doc false
  def changeset(message, attrs) do
    message
    |> cast(attrs, [:msg, :user_id, :chat_id])
    |> validate_required([:msg, :user_id, :chat_id])
  end
end