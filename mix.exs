defmodule AstarteDevTool.MixProject do
  use Mix.Project

  def project do
    [
      app: :astarte_dev_tool,
      version: "0.1.0",
      elixir: "~> 1.15",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      escript: escript_config()
    ]
  end

  defp escript_config() do
    [
      main_module: AstarteDevTool.CLI,
      name: "astarte-dev-tool",
      app: nil
      # embed_elixir: true
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      applications: [:ex_termbox, :ratatouille],
      extra_applications: [:logger],
      mod: {AstarteDevTool.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:owl, "~> 0.9"},
      {:ratatouille, "~> 0.5.0"},
      {:ex_termbox, "~> 1.0"},
      {:ucwidth, "~> 0.2"},
      {:exandra, "~> 0.10.2"},
      {:astarte_import,
       git: "https://github.com/astarte-platform/astarte.git",
       sparse: "/tools/astarte_import",
       tag: "v1.2.0-rc.0"}
      # {:dep_from_hexpm, "~> 0.3.0"},
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"}
    ]
  end
end
