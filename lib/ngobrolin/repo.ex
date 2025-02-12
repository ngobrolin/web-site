defmodule Ngobrolin.Repo do
  use Ecto.Repo,
    otp_app: :ngobrolin,
    adapter: Ecto.Adapters.Postgres
end
