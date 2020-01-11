defmodule Hls.Chats.Chat do
  use Ecto.Schema
  import Ecto.Changeset
  alias Hls.Accounts.User

  schema "messages" do
    field :msg, :string
    field :user_id, :id
    field :board_user_id, :id

    timestamps()
  end

  @doc false
  def changeset(chat, params \\ %{}) do
    chat
    |> cast(params, [:msg, :user_id, :board_user_id])
    |> validate_required([:msg, :user_id, :board_user_id])
  end
end
