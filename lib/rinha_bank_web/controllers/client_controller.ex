defmodule RinhaBankWeb.ClientController do
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

  def show_last_statements(conn, params) do
    Logger.info("Show statements with params: #{inspect(params)}")

    case ClientService.show_last_statements(params) do
      {:ok, statements} ->
        conn
        |> put_status(:ok)
        |> json(statements)

      {:error, :user_not_found} ->
        conn
        |> put_status(:not_found)
        |> json(%{error: "User not found"})

      {:error, error} ->
        Logger.info("Error to show statements: #{inspect(error)}")

        conn
        |> put_status(:internal_server_error)
        |> json(%{error: "Internal server error"})
    end
  end
end
