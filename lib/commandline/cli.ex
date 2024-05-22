defmodule AstarteDevTool.Commandline.CLI do
  alias Owl.IO, as: IO
  alias Owl.Box

  def main(args) do
    {opts, _, _} = OptionParser.parse(args, switches: [file: :string], aliases: [f: :file])
    # here I just inspect the options to stdout
    # IO.inspect(opts)
    loop()

    # AstarteDevTool.example()
  end

  defp loop() do
    prompt = """
    Seleziona un'opzione:
    1. Saluta
    2. Esci
    """

    IO.puts(Box.new(prompt, padding: 1))
    IO.input() |> IO.puts()
    loop()
  end
end
