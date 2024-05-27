defmodule AstarteDevTool do
  alias AstarteDevTool.Theme

  @options %{
    idle: [
      {:up, "Up Astarte containers detached"},
      {:down, "Down Astarte containers detached"},
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
    {opts, _, _} = OptionParser.parse(args, switches: [file: :string], aliases: [f: :file])
    loop(opts, [:idle])
    :ok
  end

  defp loop(opts, [current_state | _] = state) do
    {name, _} =
      Owl.IO.select(@options[current_state],
        render_as: fn {name, description} ->
          [
            name
            |> Atom.to_string()
            |> Owl.Data.tag(Theme.color(:primary)),
            "\n\t",
            Owl.Data.tag(description, :light_black)
          ]
        end
      )

    op(name, opts, state)
  end

  defp op(:up, opts, state) do
    # Do the docker up
    loop(opts, [:up | state])
  end

  defp op(:exit, _, _) do
    :ok
  end

  defp op(:back, opts, [_ | state]) do
    loop(opts, state)
  end
end
