defmodule AstarteDevTool.Commands.System.Watch do
  @moduledoc false
  use AstarteDevTool.Constants.System
  require Logger
  alias AstarteDevTool.Utilities.Process, as: AstarteProcess

  def exec(path) do
    # Kill zombie watching process
    with {:ok, pid} <- AstarteProcess.check_process(@command, @command_watch_args, path),
         {_result, 0} <- System.cmd("kill", [pid]) do
      Logger.info("Watching zombie process ##{pid} killed")
    else
      {:ok, nil} -> :ok
      _ -> {:error, "Cannot kill zombie process"}
    end

    with {_result, 0} <-
           System.cmd(@command, @command_watch_args, @options ++ [cd: path]) do
      :ok
    else
      {:error, reason} -> {:error, "Cannot run system watching: #{reason}"}
      {result, exit_code} -> {:error, "Cannot exec system.watch: #{result}, #{exit_code}"}
    end
  end
end
