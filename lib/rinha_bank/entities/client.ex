defmodule RinhaBank.Entities.Client do
  alias RinhaBank.Repo
  alias RinhaBank.Entities.Schema.Client

  def update_balance(client, new_balance) do
    client
    |> Client.changeset(%{saldo: new_balance})
    |> Repo.update()
  end

  def get_by_id(id) do
    Repo.get(Client, id)
  end
end
