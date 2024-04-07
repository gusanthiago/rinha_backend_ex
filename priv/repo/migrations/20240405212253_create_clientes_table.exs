defmodule RinhaBank.Repo.Migrations.CreateClientesTable do
  use Ecto.Migration

  def change do
    create table(:clientes) do
      add :nome, :string, null: false
      add :limite, :bigint, null: false
      add :saldo, :bigint, null: false
    end
  end
end
