defmodule AstarteDevTool.Application do
  @moduledoc """
  Documentation for `AstarteDevTool`.
  """

  use Application

  @impl true
  def start(_type, args) do
    AstarteDevTool.main(args)

    {:ok, self()}
  end
end
