defmodule Mix.Tasks.AstarteDevTool.System.Down do
  use Mix.Task
  alias AstarteDevTool.Commands.System.Down
  alias AstarteDevTool.Utilities.Path

  @shortdoc "Down the local Astarte system"

  @aliases [
    p: :path,
    v: :volumes
  ]

  @switches [
    path: :string,
    volumes: :boolean,
    log_level: :string
  ]

  @moduledoc """
  Down the local Astarte system.

  ## Examples

      $ mix system.down -p /path/astarte
      $ mix system.down -v

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
         {:ok, abs_path} <- Path.normalize_path(path),
         _ = Mix.shell().info("Stopping astarte system..."),
         :ok <- Down.exec(abs_path, opts[:volumes]) do
      Mix.shell().info("Astarte's system stopped successfully.")
      :ok
    else
      {:error, output} ->
        Mix.raise("Failed to stop Astarte's system. Output: #{output}")
    end
  end
end
