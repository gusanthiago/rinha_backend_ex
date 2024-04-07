defmodule RinhaBankWeb.ClientsController do
  require Logger
  use RinhaBankWeb, :controller

  alias RinhaBankWeb.Services.ClientService

  def create_transaction(conn, params) do
    Logger.info("Creating transaction with params: #{inspect(params)}")

    response = ClientService.create_transaction(params)

    conn
    |> put_status(:ok)
    |> json(response)
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
