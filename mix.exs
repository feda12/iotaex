defmodule IotaEx.MixProject do
  use Mix.Project

  def project do
    [
      app: :iota_ex,
      version: "0.1.0",
      elixir: "~> 1.6",
      start_permanent: Mix.env() == :prod,
      elixirc_paths: elixirc_paths(Mix.env),
      deps: deps(),

      # ExDoc
      name: "IotaEx",
      source_url: "https://github.com/feda12/iotaex",
      docs: [
        main: "IotaEx",
        extras: ["README.md"]
      ]
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_),     do: ["lib"]

  defp deps do
    [
      {:httpotion, "~> 3.1.0"},
      {:poison, "~> 3.1"},

      {:ex_doc, "~> 0.18.0", only: :dev, runtime: false}
    ]
  end
end
