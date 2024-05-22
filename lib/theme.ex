defmodule AstarteDevTool.Theme do
  @theme %{
    primary: {56, 62, 162}
  }

  def color(:primary), do: colors(@theme.primary)

  defp colors(color) do
    color |> rgb_to_ansi() |> IO.ANSI.color()
  end

  defp rgb_to_ansi({r, g, b}) when r in 0..255 and g in 0..255 and b in 0..255 do
    16 + 36 * div(r, 51) + 6 * div(g, 51) + div(b, 51)
  end
end
