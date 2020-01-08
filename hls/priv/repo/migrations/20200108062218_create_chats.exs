defmodule Hls.Repo.Migrations.CreateChats do
  use Ecto.Migration

  def change do
    create table(:chats) do
      add :user_id, references(:users, on_delete: :nothing), null: false

      timestamps()
    end

    create index(:chats, [:user_id])
  end
end
