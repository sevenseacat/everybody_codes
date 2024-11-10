defmodule Y2024.Day01 do
  @needed %{"A" => 0, "B" => 1, "C" => 3, "D" => 5}

  @doc """
  iex> Day01.part1("ABBAC")
  5
  """
  def part1(input) do
    input
    |> String.graphemes()
    |> Enum.frequencies()
    |> Enum.reduce(0, fn {enemy, count}, total ->
      total + count * Map.fetch!(@needed, enemy)
    end)
  end

  @doc """
  iex> Day01.part2("AxBCDDCAxD")
  28
  """
  def part2(input, group_size \\ 2) do
    input
    |> String.graphemes()
    |> Enum.chunk_every(group_size)
    |> Enum.reduce(0, fn round, total ->
      round = Enum.reject(round, &(&1 == "x"))
      extras = length(round) - 1

      Enum.reduce(round, total, fn enemy, total ->
        total + (Map.get(@needed, enemy, 0) + extras)
      end)
    end)
  end

  @doc """
  iex> Day01.part3("xBxAAABCDxCC")
  30
  """
  def part3(input), do: part2(input, 3)

  def input(part) do
    input_folder = __ENV__.file |> Path.dirname()

    "#{input_folder}/input/day01/part#{part}.txt"
    |> File.read!()
    |> String.trim_trailing()
  end
end
