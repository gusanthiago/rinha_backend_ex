defmodule RinhaBank.Entities.Schema.Transaction do
  use Ecto.Schema

  alias RinhaBank.Entities.Schema.Client

  schema "transacoes" do
    field :valor, :integer
    field :tipo, :integer
    field :descricao, :integer
    field :realizada_em, :utc_datetime
    belongs_to :client, Client
  end
end
