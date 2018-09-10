use Mix.Config

alias HttpApp.Router, as: Router

config :app, http_port: 8085
config :app, Router, server: true
