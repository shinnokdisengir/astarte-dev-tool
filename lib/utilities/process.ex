defmodule AstarteDevTool.Utilities.Process do
  def check_process(command, args, path) when is_list(args) do
    check_process(command <> " " <> Enum.join(args, " "), path)
  end

  def check_process(command, path) when is_bitstring(command) and is_bitstring(path) do
    with {pids_str, 0} <- System.cmd("pgrep", ["-f", command]),
         pids when pids != [] <- String.split(String.trim(pids_str), "\n"),
         {:ok, _pid} <- find_matching_pid(pids, path) do
      :ok
    else
      {_, _} -> {:error, "Unable to find the process."}
      [] -> {:error, "No matching process found."}
      {:error, reason} -> {:error, reason}
    end
  end

  defp find_matching_pid([], _path), do: {:error, "No matching process found."}

  defp find_matching_pid([pid | rest], path) do
    with {:ok, cwd_path} <- get_cwd(pid) do
      if cwd_path == path do
        {:ok, pid}
      else
        find_matching_pid(rest, path)
      end
    else
      {:error, reason} -> {:error, reason}
    end
  end

  defp get_cwd(pid) do
    case :os.type() do
      {:unix, :darwin} -> get_cwd_darwin(pid)
      {:unix, :linux} -> get_cwd_linux(pid)
      _ -> {:error, "Unsupported operating system."}
    end
  end

  defp get_cwd_linux(pid) do
    File.read_link("/proc/#{pid}/cwd")
  end

  defp get_cwd_darwin(pid) do
    with {output, 0} <- System.cmd("lsof", ["-p", pid]),
         [_, cwd_path] <- Regex.run(~r/\s+cwd\s+(.*?)\s+/, output) do
      {:ok, cwd_path}
    else
      {_, _} -> {:error, "Error running lsof on macOS."}
      _ -> {:error, "Unable to determine the working directory on macOS."}
    end
  end
end
