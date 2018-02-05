defmodule Authy.Mixfile do
  use Mix.Project

  def project do
    [app: :authy,
     version: "0.2.1",
     elixir: "~> 1.6.1",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps()]
  end

  def application do
    [applications: [:httpoison, :logger]]
  end

  defp deps do
    [{:httpoison, "~> 1.0"},
     {:poison, "~> 3.1"}]
  end
end
