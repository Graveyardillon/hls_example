defmodule Hls.Repo.Migrations.CreateMessages do
  use Ecto.Migration

  def change do
    create table(:messages) do
      add :msg, :text, null: false
      add :user_id, references(:users, on_delete: :nothing), null: false
      add :board_user_id, references(:users, on_delete: :nothing), null: false

      timestamps()
    end

    create index(:messages, [:user_id])
    create index(:messages, [:board_user_id])
  end
end
