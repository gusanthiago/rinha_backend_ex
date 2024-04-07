defmodule RinhaBank.Repo.Migrations.CreateTransacoesTable do
  use Ecto.Migration

  def change do
    create table(:transacoes) do
      add :cliente_id, references(:clientes)
      add :valor, :integer, null: false
      add :tipo, :char, null: false
      add :descricao, :string, null: true
      add :realizada_em, :utc_datetime, default: fragment("now()")
    end
  end
end
