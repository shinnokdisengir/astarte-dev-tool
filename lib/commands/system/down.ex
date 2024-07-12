defmodule AstarteDevTool.Commands.System.Down do
  @moduledoc false
  use AstarteDevTool.Constants.System

  def exec(path, volumes \\ false) do
    args = if volumes, do: @command_down_args ++ ["-v"], else: @command_down_args

    with {_result, 0} <-
           System.cmd(@command, args, @options ++ [cd: path]) do
      :ok
    else
      {:error, reason} -> {:error, "System is not up and running: #{reason}"}
      {result, exit_code} -> {:error, "Cannot exec system.down: #{result}, #{exit_code}"}
    end
  end
end
