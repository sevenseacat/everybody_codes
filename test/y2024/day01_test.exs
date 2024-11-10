defmodule Y2024.Day01Test do
  use ExUnit.Case, async: true

  alias Y2024.Day01
  doctest Day01

  test "part 1 verification", do: assert(Day01.part1_verify() == 1289)
  test "part 2 verification", do: assert(Day01.part2_verify() == 5552)
  test "part 3 verification", do: assert(Day01.part3_verify() == 27924)
end
