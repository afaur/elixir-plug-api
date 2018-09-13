use Mix.Config

alias HttpApp.Router, as: Router

config :app, port: (System.get_env("SERVER_PORT") || "8080") |> String.to_integer
config :app, Router, server: true
