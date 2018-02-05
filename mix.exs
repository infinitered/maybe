defmodule Maybe.MixProject do
  use Mix.Project

  def project do
    [
      app: :maybe,
      description: "Nil protection for nested maps and structs",
      version: "1.0.0",
      elixir: "~> 1.4",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      docs: docs(),
      package: package()
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  def package do
    [
      maintainers: ["Daniel Berkompas"],
      licenses: ["MIT"],
      links: %{
        "GitHub" => "https://github.com/infinitered/maybe"
      },
      source_url: "https://github.com/infinitered/maybe"
    ]
  end

  defp docs do
    [
      main: Maybe
    ]
  end

  defp deps do
    [
      {:ex_doc, ">= 0.0.0", only: [:dev, :test]}
    ]
  end
end
