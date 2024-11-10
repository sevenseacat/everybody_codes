defmodule Y2024.Day01 do
  use EC.Day, no: 1

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

  def part1_verify, do: input("part1") |> part1()
  def part2_verify, do: input("part2") |> part2()
  def part3_verify, do: input("part3") |> part3()
end
