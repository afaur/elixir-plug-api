use Mix.Config

scheme = String.to_atom(System.get_env("SERVER_PROTOCOL") || "http")
port   = String.to_integer(System.get_env("SERVER_PORT") || "8080")

if (scheme == :https) do
  config :app, plug_options: [
    password: "cowboy",
    keyfile:  Path.expand("../../conf/ssl/server.key", __DIR__),
    certfile: Path.expand("../../conf/ssl/server.cer", __DIR__),
    port:     port,
  ]
else
  config :app, plug_options: [ port: port ]
end

config :app, plug_scheme: scheme
