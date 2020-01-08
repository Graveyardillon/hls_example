defmodule Hls.Repo.Migrations.CreateMessages do
  use Ecto.Migration

  def change do
    create table(:messages) do
      add :msg, :text
      add :user_id, :integer
      add :chat_id, :integer

      timestamps()
    end

  end
end
