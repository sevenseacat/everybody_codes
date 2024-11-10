defmodule Y2024.Day02Test do
  use ExUnit.Case, async: true

  alias Y2024.Day02
  doctest Day02

  test "part 1 verification", do: assert(Day02.part1_verify() == 32)
  test "part 2 verification", do: assert(Day02.part2_verify() == 5296)

  describe "part 2" do
    @runic_words ["THE", "OWE", "MES", "ROD", "HER"]

    test "line 1" do
      assert Day02.part2(%{
               runic_words: @runic_words,
               lines: ["AWAKEN THE POWE ADORNED WITH THE FLAMES BRIGHT IRE"]
             }) == 15
    end
  end
end
