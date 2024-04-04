defmodule RinhaBank.Repo do
  use Ecto.Repo,
    otp_app: :rinha_bank,
    adapter: Ecto.Adapters.Postgres
end
