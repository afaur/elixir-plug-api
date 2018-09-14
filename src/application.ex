defmodule HttpApp.Application do
  use Application

  require Logger

  def start(_type, _args) do
    port = Application.get_env(:app, :port, 8080)

    children = [
      Plug.Adapters.Cowboy2.child_spec(
        scheme: :http,
        plug: HttpApp.Router,
        options: [ port: port ]
      )
    ]

    opts = [ strategy: :one_for_one, name: HttpApp.Supervisor ]

    Logger.info("Application running on port: #{port}")
    Supervisor.start_link(children, opts)
  end
end
