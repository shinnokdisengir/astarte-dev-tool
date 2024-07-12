defmodule AstarteDevTool.Constants.System do
  defmacro __using__(_opts) do
    quote do
      @command "docker"
      @command_up_args [
        "compose",
        "-f",
        "docker-compose.yml",
        "-f",
        "docker-compose.dev.yml",
        "up",
        "--build",
        "--watch",
        "-d"
      ]
      @command_down_args [
        "compose",
        "-f",
        "docker-compose.yml",
        "-f",
        "docker-compose.dev.yml",
        "down"
      ]
      @command_watch_args [
        "compose",
        "-f",
        "docker-compose.yml",
        "-f",
        "docker-compose.dev.yml",
        "watch",
        "--no-up"
      ]
      @options [stderr_to_stdout: true, into: IO.stream(:stdio, :line)]
    end
  end
end
