defmodule Samly.Mixfile do
  use Mix.Project

  @version "1.0.0"
  @description "SAML Single-Sign-On Authentication for Plug/Phoenix Applications"
  @source_url "https://github.com/RobotsAndPencils/elixir-aai-samly"

  def project() do
    [
      app: :samly,
      version: @version,
      description: @description,
      docs: docs(),
      package: package(),
      elixir: "~> 1.18",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application() do
    [
      extra_applications: [:logger, :eex]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps() do
    [
      {:plug, "~> 1.6"},
      {:esaml, "~> 4.2"},
      {:sweet_xml, "~> 0.7"},
      {:ex_doc, "~> 0.38", only: :dev, runtime: false}
    ]
  end

  defp docs() do
    [
      extras: ["README.md"],
      main: "readme",
      source_ref: "v#{@version}",
      source_url: @source_url
    ]
  end

  defp package() do
    [
      name: :rnp_samly,
      maintainers: ["Robots & Pencils"],
      files: ["config", "lib", "LICENSE", "mix.exs", "README.md"],
      licenses: ["MIT"],
      links: %{
        "GitHub" => @source_url
      }
    ]
  end
end
