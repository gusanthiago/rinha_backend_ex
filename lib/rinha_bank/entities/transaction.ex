defmodule RinhaBank.Entities.Transaction do
  alias RinhaBank.Repo
  alias RinhaBank.Entities.Schema.Transaction

  import Ecto.Query

  @spec create(map()) :: {:ok, Transaction.t()} | {:error, Changeset.t()}
  def create(params) do
    %Transaction{}
    |> Transaction.changeset(params)
    |> Repo.insert()
  end

  def get_last_transactions(client_id, limit) do
    Repo.all(
      from t in Transaction,
        where: t.cliente_id == ^client_id,
        limit: ^limit,
        order_by: [desc: t.realizada_em]
    )
  end
end
