defmodule ElixirDevcontainerExample.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      ElixirDevcontainerExampleWeb.Telemetry,
      ElixirDevcontainerExample.Repo,
      {DNSCluster, query: Application.get_env(:elixir_devcontainer_example, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: ElixirDevcontainerExample.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: ElixirDevcontainerExample.Finch},
      # Start a worker by calling: ElixirDevcontainerExample.Worker.start_link(arg)
      # {ElixirDevcontainerExample.Worker, arg},
      # Start to serve requests, typically the last entry
      ElixirDevcontainerExampleWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: ElixirDevcontainerExample.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    ElixirDevcontainerExampleWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
