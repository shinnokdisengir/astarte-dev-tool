defmodule Mix.Tasks.AstarteDevTool.System.Down do
  use Mix.Task

  @shortdoc "Down the local Astarte system"

  @aliases [
    v: :volumes
  ]

  @switches [
    volumes: :boolean,
    log_level: :string
  ]

  @moduledoc """
  Down the local Astarte system.

  ## Examples

      $ mix system.down
      $ mix system.down -v
      $ mix system.down --volumes

  ## Command line options

    * `--log-level` - the level to set for `Logger`. This task
      does not start your application, so whatever level you have configured in
      your config files will not be used. If this is not provided, no level
      will be set, so that if you set it yourself before calling this task
      then this won't interfere. Can be any of the `t:Logger.level/0` levels

    * `-v`, `--volumes` - remove volumes

  """

  @impl true
  def run(args) do
    {opts, _} = OptionParser.parse!(args, strict: @switches, aliases: @aliases)

    if log_level = opts[:log_level] do
      Logger.configure(level: String.to_existing_atom(log_level))
    end

    Mix.shell().info("Stopping Astarte system...")

    cmd_args = ["compose", "down"]
    cmd_args = if opts[:volumes], do: [cmd_args | "-v"], else: cmd_args

    {output, exit_code} =
      System.cmd("docker", cmd_args, into: IO.stream(:stdio, :line))

    if exit_code == 0 do
      Mix.shell().info("Astarte's system started successfully.")
    else
      Mix.shell().error("Failed to start Astarte's system. Output: #{output}")
    end

    :ok
  end
end
