use Mix.Config

scheme = :http
port   = 8085

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

import_config Path.expand("../../conf/private.exs", __DIR__)
