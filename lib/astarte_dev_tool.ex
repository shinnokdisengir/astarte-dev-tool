defmodule AstarteDevTool do
  require Logger
  alias AstarteDevTool.Theme
  alias AstarteDevTool.Commands

  @pad 8
  @options %{
    idle: [
      {:config, "Config tool"},
      {:up, "Up Astarte containers detached"},
      # {:down, "Down Astarte containers detached"},
      {:shell, "Open shell"},
      {:exit, "Exit"}
    ],
    up: [
      {:device, "Device mode"},
      {:shell, "Open shell"},
      {:back, "Back main menu"}
    ],
    device: [
      {:insert_device, "Insert device"},
      {:remove_device, "Remove device"},
      {:shell, "Open shell"},
      {:back, "Back main menu"}
    ]
  }

  def main(args) do
    {opts, _, _} = OptionParser.parse(args, switches: [verbose: :boolean], aliases: [v: :verbose])
    IO.inspect(opts)
    # Logger.configure(level: :info)
    loop(opts, [:idle], %{})
  end

  defp loop(opts, [position | _] = stack, state) do
    Logger.warning("State: #{inspect(state)}")

    {name, _} =
      Owl.IO.select(@options[position],
        label: "Select",
        render_as: fn {name, description} ->
          [
            name
            |> Atom.to_string()
            |> String.pad_trailing(@pad, " ")
            |> Owl.Data.tag(Theme.color(:primary)),
            description
            |> Owl.Data.tag(:light_black)
          ]
        end
      )

    case Commands.run(name, opts, stack, state) do
      :halt -> :ok
      {:ok, new_stack, new_state} -> loop(opts, new_stack, new_state)
    end
  end
end
