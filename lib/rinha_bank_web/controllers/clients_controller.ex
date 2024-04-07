defmodule RinhaBankWeb.ClientsController do
  require Logger
  use RinhaBankWeb, :controller

  alias RinhaBankWeb.Services.ClientService

  def create_transaction(conn, params) do
    Logger.info("Creating transaction with params: #{inspect(params)}")

    case ClientService.create_transaction(params) do
      {:ok, client} ->
        conn
        |> put_status(:ok)
        |> json(%{
          saldo: client.saldo,
          limite: client.limite
        })

      {:error, :insuficient_funds} ->
        conn
        |> put_status(:unprocessable_entity)
        |> json(%{error: "Insuficient funds"})

      {:error, error} ->
        Logger.info("Error to create transaction: #{inspect(error)}")

        conn
        |> put_status(:unprocessable_entity)
        |> json(%{error: error})
    end
  end

  def show_transaction(conn, params) do
    Logger.info("show transaction with: #{inspect(params)}")

    conn
    |> put_status(:ok)
    |> json(%{})
  end

  def show_statements(conn, params) do
    Logger.info("Show statements with params: #{inspect(params)}")

    conn
    |> put_status(:ok)
    |> json(%{})
  end
end
