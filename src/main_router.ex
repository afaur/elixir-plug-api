defmodule HttpApp.MainRouter do
  use HttpApp.BaseRouter

  use NewRelic.Transaction

  _ = """
  Bring in all functions from `ViewHandler` module
    - The `index` function will render the `index.eex`
      template from `www/index.eex` with dynamic content
  """
  import HttpApp.ViewHandler

  _ = """
  Serve HTML content for Site Root requests
    - Send a precompiled eex template that we render with dynamic data
  """
  get        "/", do: send_resp conn, 200, index("Dynamic Content")

  _ = "Forward `/api` requests to the `RestHandler` Module"
  forward "/api", to: HttpApp.RestHandler

  _ = "Status 404 - Routes without any handler"
  match        _, do: send_resp conn, 404, "Page not found"
end
