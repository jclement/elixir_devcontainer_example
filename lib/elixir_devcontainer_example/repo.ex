defmodule ElixirDevcontainerExample.Repo do
  use Ecto.Repo,
    otp_app: :elixir_devcontainer_example,
    adapter: Ecto.Adapters.Postgres
end
