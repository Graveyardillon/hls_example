defmodule Hls.Chat.Message do
  use Ecto.Schema
  import Ecto.Changeset

  schema "messages" do
    field :chat_id, :integer
    field :msg, :string
    field :user_id, :integer

    timestamps()
  end

  @doc false
  def changeset(message, attrs) do
    message
    |> cast(attrs, [:msg, :user_id, :chat_id])
    |> validate_required([:msg, :user_id, :chat_id])
  end
end
