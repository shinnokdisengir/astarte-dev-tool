defmodule AstarteDevTool.Commands.System.Up do
  @moduledoc false
  use AstarteDevTool.Constants.System

  def exec(path) do
    with {_result, 0} <-
           System.cmd(@command, @command_up_args, @options ++ [cd: path]) do
      :ok
    else
      {:process, _} -> {:error, "The system is already running"}
      {result, exit_code} -> {:error, "Cannot exec system.up: #{result}, #{exit_code}"}
    end
  end
end
