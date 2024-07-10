defmodule AstarteDevTool.Commands.System.Up do
  @moduledoc false

  defmacro __using__(_opts) do
    quote do
      @aliases [
        p: :path
      ]

      @opts [
        path: :string,
        log_level: :string
      ]
    end
  end

  def exec(path) do
    cmd_args = [
      "compose",
      "-f",
      "docker-compose.yml",
      "-f",
      "docker-compose.dev.yml",
      "up",
      "--watch"
    ]

    with {output, 0} <- System.cmd("docker", cmd_args, into: IO.stream(:stdio, :line), cd: path) do
      {:ok, {output, 0}}
    else
      result -> {:error, result}
    end
  end
end
