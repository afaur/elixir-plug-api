defmodule HttpApp.BaseRouter do
  defmacro __using__(_opts) do
    quote do
      use Plug.Router
      use Plug.ErrorHandler
      use Plug.Debugger

      require Logger
      plug(Plug.Logger, log: :debug)

      plug :match
      plug :dispatch
    end
  end
end
