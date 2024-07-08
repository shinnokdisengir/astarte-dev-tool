defmodule AstarteDevTool.CLI do
  @moduledoc """
  Documentation for `AstarteDevTool`.
  """

  use Application

  @impl true
  def start(_type, args) do
    run(args)
    {:ok, self()}
  end

  def main(args) do
    run(args)
  end

  defp run(args) do
    {opts, _, _} = OptionParser.parse(args, switches: [verbose: :boolean], aliases: [v: :verbose])
    Ratatouille.run(AstarteDevTool.App, opts)
  end
end
