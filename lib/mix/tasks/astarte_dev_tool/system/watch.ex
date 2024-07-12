defmodule Mix.Tasks.AstarteDevTool.System.Watch do
  use Mix.Task
  alias AstarteDevTool.Commands.System.Watch
  alias AstarteDevTool.Utilities.Path

  @shortdoc "Attach watching mode to the up and running system"

  @aliases [
    p: :path
  ]

  @switches [
    log_level: :string
  ]

  @moduledoc """
  Attach watching mode to the up and running system.

  ## Examples

      $ mix system.watch -p /path/astarte

  ## Command line options
    * `-p` `--path` - (required) working Astarte project directory

    * `--log-level` - the level to set for `Logger`. This task
      does not start your application, so whatever level you have configured in
      your config files will not be used. If this is not provided, no level
      will be set, so that if you set it yourself before calling this task
      then this won't interfere. Can be any of the `t:Logger.level/0` levels
  """

  @impl true
  def run(args) do
    {opts, _} = OptionParser.parse!(args, strict: @switches, aliases: @aliases)

    unless Keyword.has_key?(opts, :path), do: Mix.raise("The --path argument is required")

    if log_level = opts[:log_level],
      do: Logger.configure(level: String.to_existing_atom(log_level))

    with path <- opts[:path],
         {:ok, abs_path} <- Path.normalize_path(path) do
      Mix.shell().info("Entering Watch mode...")
      Watch.exec(abs_path)
    else
      {:error, output} ->
        Mix.raise("Failed to watch Astarte's system. Output: #{output}")
    end
  end
end
