defmodule RinhaBankWeb.Services.ClientService do
  require Logger
  alias RinhaBank.Repo
  alias RinhaBank.Entities.Client
  alias RinhaBank.Entities.Transaction

  def create_transaction(
        %{
          "tipo" => tipo
        } = params
      ) do
    case tipo do
      "c" -> deposit(params)
      _ -> {:error, "Invalid transaction type"}
    end
  end

  defp deposit(
         %{
           "id" => id
         } = params
       ) do
    transaction =
      Repo.transaction(fn ->
        case increase_balance(params) do
          {:ok, client} ->
            Logger.info("Client balance updated: #{inspect(client)}, inserting transaction ...")

            case insert_transaction(params) do
              {:ok, transaction} ->
                Logger.info("Transaction inserted with successfully #{inspect(transaction)}")
                transaction

              {:error, error} ->
                Logger.info("Transaction not created, rolling back ... #{inspect(error)}")
                Repo.rollback(:failed_transaction)
                {:error, "Transaction not created"}
            end

          {:error, _} ->
            Logger.info("Error to update client balance")
        end
      end)

    mapper_transaction_result(transaction)
  end
end

defp increase_balance(%{
       "valor" => valor,
       "id" => client_id
     }) do
  client = Client.get_by_id(client_id)
  new_balance = client.saldo + valor
  Logger.info("Client #{inspect(client)} || New balance: #{new_balance}")
  Client.update_balance(client, new_balance)
end

defp insert_transaction(%{
       "valor" => valor,
       "id" => id,
       "descricao" => descricao,
       "tipo" => tipo
     }) do
  %{
    valor: valor,
    tipo: tipo,
    descricao: descricao,
    cliente_id: id
  }
  |> Transaction.create()
end

defp mapper_transaction_result(transaction) do
  case transaction do
    {:ok, _} ->
      Logger.info("Transaction created with successfully")
      {:ok, Client.get_by_id(id)}

    {:error, _} ->
      {:error, "Transaction not created"}
  end
end
