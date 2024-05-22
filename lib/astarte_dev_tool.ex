defmodule AstarteDevTool do
  alias AstarteDevTool.Theme

  def main(args) do
    {opts, _, _} = OptionParser.parse(args, switches: [file: :string], aliases: [f: :file])
    # here I just inspect the options to stdout
    loop(opts)
    :ok
  end

  defp loop(opts) do
    prompt = """
    Select option:
    """

    options = [
      %{name: "shell", description: "shell"},
      %{name: "exit", description: "exit tool"}
    ]

    selection =
      Owl.IO.select(options,
        render_as: fn %{name: name, description: description} ->
          [
            Owl.Data.tag(name, Theme.color(:primary)),
            # Owl.Data.tag(name, Theme.rgb_to_ansi(Theme.theme().primary)),
            "\n  ",
            Owl.Data.tag(description, :light_black)
          ]
        end
      )

    case selection do
      %{name: "shell"} ->
        Owl.IO.input() |> Owl.IO.puts()
        loop(opts)

      _ ->
        :ok
    end

    # IO.puts(Box.new(prompt, padding: 1))
    # IO.select(["shell", "exit"])
    # # IO.input()
    # loop(opts)
  end
end
