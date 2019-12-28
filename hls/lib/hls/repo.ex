defmodule Hls.Repo do
  use Ecto.Repo,
    otp_app: :hls,
    adapter: Ecto.Adapters.Postgres
end
