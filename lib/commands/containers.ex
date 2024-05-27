defmodule AstarteDevTool.Commands.Containers do
  def up(_opts, %{astarte_path: astarte_path}) do
    {output, return} =
      System.cmd("docker-compose", ["up", "-d"], into: IO.stream(:stdio, :line), cd: astarte_path)

    IO.inspect(output)
    IO.inspect(return)
  end
end
