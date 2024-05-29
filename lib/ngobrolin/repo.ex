defmodule Ngobrolin.Repo do
  use Ecto.Repo,
    otp_app: :ngobrolin,
    adapter: Ecto.Adapters.SQLite3
end
