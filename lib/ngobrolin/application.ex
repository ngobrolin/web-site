defmodule Ngobrolin.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      NgobrolinWeb.Telemetry,
      Ngobrolin.Repo,
      {DNSCluster, query: Application.get_env(:ngobrolin, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: Ngobrolin.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: Ngobrolin.Finch},
      # Start a worker by calling: Ngobrolin.Worker.start_link(arg)
      # {Ngobrolin.Worker, arg},
      # Start to serve requests, typically the last entry
      NgobrolinWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Ngobrolin.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    NgobrolinWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
