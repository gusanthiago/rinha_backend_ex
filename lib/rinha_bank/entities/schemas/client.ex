defmodule RinhaBank.Entities.Schema.Client do
  use Ecto.Schema

  schema "clientes" do
    field :nome, :string
    field :limite, :integer
    field :saldo, :integer
  end
end
