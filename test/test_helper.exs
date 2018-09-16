defmodule WebCase do
  use ExUnit.CaseTemplate

  setup_all do
    {:ok, [
      scheme: Application.get_env(:app, :plug_scheme),
      port:   Application.get_env(:app, :plug_options)[:port],
    ]}
  end

  using do
    quote do
      defp res(data),      do: {:ok, Poison.encode!(data, pretty: true)}
      defp base(),         do: "://127.0.0.1"
      defp path(ctx, loc), do: "#{ctx[:scheme]}#{base()}:#{ctx[:port]}#{loc}"
      defp expand(path),   do: Path.expand path, __DIR__
      defp cert(),         do: expand "../../conf/ssl/client.key"
      defp opts(),         do: [ ssl: [ certfile: cert() ] ]
      defp get(ctx, loc),  do: response HTTPoison.get(path(ctx, loc), [], opts())

      defp response(
        { :ok, %{ status_code: 200, body: body } }
      ), do: { :ok, body }

      defp response(
        { :ok, %{ status_code: status_code } }
      ), do: { :error, "HTTP Status #{status_code}" }

      defp response(
        { :error, %{ reason: reason } }
      ), do: { :error, reason }
    end
  end
end

ExUnit.start()
