defmodule RinhaBank.Entities.Transaction do
  alias RinhaBank.Repo
  alias RinhaBank.Entities.Schema.Transaction

  @spec create(map()) :: {:ok, Transaction.t()} | {:error, Changeset.t()}
  def create(params) do
    %Transaction{}
    |> Transaction.changeset(params)
    |> Repo.insert()
  end
end
