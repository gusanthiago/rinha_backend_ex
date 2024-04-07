defmodule RinhaBank.Entities.Schema.Client do
  use Ecto.Schema
  import Ecto.Changeset

  schema "clientes" do
    field :nome, :string
    field :limite, :integer
    field :saldo, :integer
  end

  def changeset(client, params \\ %{}) do
    client
    |> cast(params, [:nome, :limite, :saldo])
    |> validate_required([:nome, :limite, :saldo])
  end
end
