defmodule HttpApp.Application do
  use Application

  require Logger

  def start(_type, _args) do
    plug_scheme  = Application.get_env :app, :plug_scheme,  :http
    plug_options = Application.get_env :app, :plug_options, [ port: 8085 ]

    children = [
      Plug.Adapters.Cowboy2.child_spec(
        scheme:  plug_scheme,
        plug:    HttpApp.MainRouter,
        options: plug_options
      )
    ]

    opts = [ strategy: :one_for_one, name: HttpApp.Supervisor ]

    Logger.info "Application running on port: #{plug_options[:port]}"
    Supervisor.start_link children, opts
  end
end
