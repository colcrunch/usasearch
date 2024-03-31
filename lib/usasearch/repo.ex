defmodule Usasearch.Repo do
  use Ecto.Repo,
    otp_app: :usasearch,
    adapter: Ecto.Adapters.MyXQL
end
