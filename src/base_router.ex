defmodule HttpApp.BaseRouter do
  defmacro __using__(opts) do
    quote do
      use Plug.Router
      if (unquote(opts)[:first_handler]), do: use NewRelic.Transaction
      use Plug.Debugger

      require Logger
      plug(Plug.Logger, log: :debug)

      plug :match
      plug :dispatch

      _ = """
      Bring in all functions from `ViewHandler` module
        - The `index` function will render the `index.eex`
          template from `www/index.eex` with dynamic content
      """
      import HttpApp.ViewHandler

      _ = """
      Bring in all functions from `WebStatus` module
        - This allows us to handle error status code responses
          while retaining route information in new relic errors
      """
      import HttpApp.WebStatus
    end
  end
end
