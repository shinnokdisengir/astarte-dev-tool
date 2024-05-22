defmodule AstarteDevTool.Application do
  @moduledoc """
  Documentation for `AstarteDevTool`.
  """

  use Application

  def start(_type, args) do
    AstarteDevTool.Commandline.CLI.main(args)
    {:ok, self()}
  end
end
