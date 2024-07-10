defmodule AstarteDevTool.Utilities.Path do
  def normalize_path(path) when is_bitstring(path) do
    with abs_path <- Path.absname(path),
         true <- File.exists?(abs_path),
         true <- File.dir?(abs_path) do
      {:ok, abs_path}
    else
      _ -> {:error, "Invalid directory: #{path}"}
    end
  end
end
