defmodule Scrappy.Mixfile do
  use Mix.Project

  def project do
    [app: :scrappy,
     version: "0.1.0",
     elixir: "~> 1.3",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     escript: [main_module: Scrappy.CLI],
     deps: deps()]
  end

  def application do
    [applications: [:logger, :httpoison, :timex]]
  end

  defp deps do
    [
      {:httpoison, "~> 0.9.0"},
      {:floki, "~> 0.10.1"},
      {:timex, "~> 3.0"},
      {:tzdata, "== 0.1.8", override: true}
    ]
  end
end
