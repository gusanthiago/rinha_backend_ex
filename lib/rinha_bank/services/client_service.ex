defmodule RinhaBankWeb.Services.ClientService do
  require Logger
  alias RinhaBank.Repo
  alias RinhaBank.Entities.Client
  alias RinhaBank.Entities.Transaction

  def create_transaction(
        %{
          "id" => client_id
        } = params
      ) do
    {:ok, transaction} =
      Repo.transaction(fn ->
        client = Client.get_by_id(client_id)

        case change_balance(params, client) do
          {:ok, client} ->
            Logger.info("Client balance updated: #{inspect(client)}, inserting transaction ...")

            case insert_transaction(params) do
              {:ok, transaction} ->
                Logger.info("Transaction inserted with successfully #{inspect(transaction)}")
                {:ok, transaction}

              {:error, error} ->
                Logger.warning("Transaction not created, rolling back ... #{inspect(error)}")
                Repo.rollback(:failed_transaction)
                {:error, "Transaction not created"}
            end

          {:error, error} ->
            Logger.info("Error to update client balance")
            {:error, error}
        end
      end)

    mapper_transaction_result(transaction, client_id)
  end

  defp change_balance(
         %{
           "valor" => valor,
           "tipo" => "c"
         },
         client
       ) do
    new_balance = client.saldo + valor
    Client.update_balance(client, new_balance)
  end

  defp change_balance(
         %{
           "valor" => valor,
           "tipo" => "d"
         },
         client
       ) do
    new_balance = client.saldo - valor

    if new_balance < 0 and new_balance * -1 > client.limite do
      {:error, :insuficient_funds}
    else
      Client.update_balance(client, new_balance)
    end
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

  defp mapper_transaction_result(transaction, client_id) do
    case transaction do
      {:ok, _} ->
        Logger.info("Transaction created with successfully")
        {:ok, Client.get_by_id(client_id)}

      {:error, error} ->
        {:error, error}
    end
  end
end
