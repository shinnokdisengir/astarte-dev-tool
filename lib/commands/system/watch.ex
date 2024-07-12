defmodule AstarteDevTool.Commands.System.Watch do
  @moduledoc false
  use AstarteDevTool.Constants.System
  alias AstarteDevTool.Utilities.Process, as: AstarteProcess

  def exec(path) do
    with :ok <- AstarteProcess.check_process(@command, @command_up_args, path),
         {_result, 0} <-
           System.cmd(@command, @command_watch_args, @options ++ [cd: path]) do
      :ok
    else
      {:error, reason} -> {:error, "Cannot run system watching: #{reason}"}
      {result, exit_code} -> {:error, "Cannot exec system.watch: #{result}, #{exit_code}"}
    end
  end
end
