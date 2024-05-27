defmodule AstarteDevTool.Commands do
  alias AstarteDevTool.Commands.Containers

  defp cast_path(path) do
    with abs_path <- Path.absname(path),
         true <- File.exists?(abs_path),
         true <- File.dir?(abs_path) do
      {:ok, abs_path}
    else
      _ -> {:error, "Invalid directory"}
    end
  end

  def run(:config, _opts, stack, state) do
    astarte_path = Owl.IO.input(label: "Astarte root path:", cast: &cast_path/1)
    {:ok, stack, Map.merge(state, %{astarte_path: astarte_path})}
  end

  # TODO task manager
  def run(:up, opts, stack, state) do
    # long_running_tasks =
    #   [9000, 8000, 4000, 6000, 1000, 12000, 1300, 6000, 3000, 7900]
    #   |> Enum.with_index(1)
    #   |> Enum.map(fn {delay, index} ->
    #     {fn -> Process.sleep(delay) end,
    #      labels: [
    #        processing: "##{index} - processing",
    #        ok: "##{index} - completed",
    #        error: "##{index} - error"
    #      ]}
    #   end)

    # Containers.up(opts, state)
    # |> Task.async_stream(
    #   fn {long_running_task, opts} ->
    #     Owl.Spinner.run(long_running_task, opts)
    #   end,
    #   timeout: :infinity
    # )
    # |> Stream.run()
    Owl.ProgressBar.start(id: :users, label: "Creating users", total: 1)

    # Containers.up(opts, state)
    Owl.ProgressBar.inc(id: :users)

    # Enum.each(1..100, fn _ ->
    #   Process.sleep(10)
    #   Owl.ProgressBar.inc(id: :users)
    # end)

    Owl.LiveScreen.await_render()
    {:ok, [:up | stack], state}
  end

  def run(:exit, _, _, _) do
    :halt
  end

  def run(:back, _opts, [_ | stack], state) do
    {:ok, stack, state}
  end
end
