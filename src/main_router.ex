defmodule HttpApp.MainRouter do
  use HttpApp.BaseRouter, first_handler: true

  _ = """
  Serve HTML content for Site Root requests
    - Send a precompiled eex template that we render with dynamic data
  """
  get        "/", do: send_resp conn, 200, index("Dynamic Content")

  _ = "Forward `/api` requests to the `RestHandler` Module"
  forward  "api", to: HttpApp.RestHandler

  _ = "Status 404 - Routes without any handler"
  match        _, do: send_missing conn
end
