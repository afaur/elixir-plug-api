defmodule HttpApp.BaseRouter do
  defmacro __using__(opts) do
    quote do
      use Plug.Router
      if (unquote(opts)[:first_handler]), do: use NewRelic.Transaction
      use Plug.ErrorHandler
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

      defp resp_end(conn, status, content) do
        conn |> send_resp(status, content) |> halt()
      end

      defp handle_errors(conn, error) do
        NewRelic.Transaction.handle_errors conn, error
        %Plug.Conn{request_path: route} = conn
        send_resp(conn, 404, missing(route))
      end
    end
  end
end
