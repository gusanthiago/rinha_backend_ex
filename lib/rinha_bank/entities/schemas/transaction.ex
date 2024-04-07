defmodule RinhaBank.Entities.Schema.Transaction do
  use Ecto.Schema
  import Ecto.Changeset

  schema "transacoes" do
    field :valor, :integer
    field :tipo, :string
    field :descricao, :string
    field :realizada_em, :utc_datetime
    belongs_to :cliente, Client
  end

  def changeset(transaction, params \\ %{}) do
    transaction
    |> cast(params, [:valor, :tipo, :descricao, :realizada_em, :cliente_id])
    |> validate_required([:valor, :tipo, :descricao, :cliente_id])
  end
end
