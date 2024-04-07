defmodule RinhaBank.Repo.Migrations.CreateDefaultUsers do
  use Ecto.Migration

  def change do
    execute """
    INSERT INTO clientes (nome, limite, saldo) VALUES
    ('o barato sai caro', 1000 * 100, 0),
    ('zan corp ltda', 800 * 100, 0),
    ('les cruders', 10000 * 100, 0),
    ('padaria joia de cocaia', 100000 * 100, 0),
    ('kid mais', 5000 * 100, 0);
    """
  end
end
