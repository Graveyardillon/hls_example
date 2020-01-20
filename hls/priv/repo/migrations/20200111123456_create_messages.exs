defmodule Hls.Repo.Migrations.CreateMessages do
  use Ecto.Migration

  def change do
    create table(:messages) do
      add :msg, :string
      add :user_id, :id
      add :chat_id, :id

      timestamps()
    end

  end
end
