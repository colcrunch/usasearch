defmodule Usasearch.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      UsasearchWeb.Telemetry,
      Usasearch.Repo,
      {DNSCluster, query: Application.get_env(:usasearch, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: Usasearch.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: Usasearch.Finch},
      # Start a worker by calling: Usasearch.Worker.start_link(arg)
      # {Usasearch.Worker, arg},
      # Start to serve requests, typically the last entry
      UsasearchWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Usasearch.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    UsasearchWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
