defmodule AstarteDevTool.Application do
  @moduledoc false

  use Application

  @impl true
  def start(_type, args) do
    {opts, _, _} = OptionParser.parse(args, switches: [verbose: :boolean], aliases: [v: :verbose])
    Ratatouille.run(AstarteDevTool.Main, opts)
    {:ok, self()}
  end
end
