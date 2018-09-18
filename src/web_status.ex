defmodule NoErrorException do defexception message: "" end
defmodule MissingError do defexception message: "Route Missing" end
defmodule NotImplError do defexception message: "Route Not Implemented" end

defmodule HttpApp.WebStatus do
  import Plug.Conn
  import NewRelic.Transaction

  _ = "View render functions for each status code supported"
  import HttpApp.ViewHandler

  defp err_reason(code, msg) do
    case code do
      404 -> try do raise(MissingError,     message: msg) rescue e -> e end
      501 -> try do raise(NotImplError,     message: msg) rescue e -> e end
      _   -> try do raise(NoErrorException, message: msg) rescue e -> e end
    end
  end

  defp view_render(code, route) do
    case code do
      404 -> missing route
      501 -> not_impl route
      _   -> index route
    end
  end

  defp get_stack(), do: Process.info(self(), :current_stacktrace) |> elem(1)

  defp get_route(%Plug.Conn{request_path: route}), do: route

  defp get_route_and_stack(conn), do: {get_route(conn), get_stack()}

  defp log_response(conn, code, message) do
    {route, stack} = get_route_and_stack conn
    reason         = err_reason code, "#{message}: #{route}"
    error          = %{ kind: :exit, stack: stack, reason: reason }
    handle_errors conn, error
    send_resp conn, code, view_render(code, route)
  end

  def send_missing(conn),  do: log_response conn, 404, "Route Missing"
  def send_not_impl(conn), do: log_response conn, 501, "Route Not Implemented"
end
