defmodule HttpApp.MixProject do
  use Mix.Project

  def project do
    [
      app: :app,
      version: "0.1.1",
      elixir: "~> 1.7",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  def application do
    [
      extra_applications: [ :logger, :cowboy, :plug, :poison, :httpoison ],
      mod: { HttpApp.Application, [] }
    ]
  end

  defp deps do
    [
      { :cowboy,          "~> 2.0" },
      { :plug,            "~> 1.6" },
      { :poison,          "~> 4.0" },
      { :httpoison,       "~> 1.0" },
      { :new_relic_agent, "~> 1.0" },
    ]
  end
end
