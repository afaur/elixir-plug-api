defmodule HttpApp.Router do
  use Plug.Router
  use Plug.ErrorHandler
  use Plug.Debugger

  use NewRelic.Transaction

  require Logger
  plug(Plug.Logger, log: :debug)

  # Bring in all functions from `ViewHandler` module
  # - The `index` function will render the `index.eex`
  #   template from `www/index.eex` with dynamic content
  import HttpApp.ViewHandler

  plug(:match)
  plug(:dispatch)

  # Serve HTML content for Site Root requests
  get "/" do
    # Send a precompiled eex template that we render with dynamic data
    send_resp(conn, 200, index("Dynamic Content"))
  end

  # Forward `/api` requests to the `RestHandler` Module
  forward "/api",  to: HttpApp.RestHandler
end
