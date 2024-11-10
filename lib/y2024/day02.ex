defmodule Y2024.Day02 do
  use EC.Day, no: 2

  @doc """
  iex> runic_words = ["THE", "OWE", "MES", "ROD", "HER"]
  iex> Day02.part1(%{runic_words: runic_words,
  ...>  lines: ["AWAKEN THE POWER ADORNED WITH THE FLAMES BRIGHT IRE"]})
  4
  iex> Day02.part1(%{runic_words: runic_words, lines: ["POWE PO WER P OWE R"]})
  2
  iex> Day02.part1(%{runic_words: runic_words, lines: ["THERE IS THE END"]})
  3
  """
  def part1(%{runic_words: runic_words, lines: lines}) do
    runic_words = Enum.map(runic_words, &{String.graphemes(&1), String.length(&1)})
    check_for_runic_words(String.graphemes(hd(lines)), runic_words, 0)
  end

  defp check_for_runic_words([], _runic_words, count), do: count

  defp check_for_runic_words(characters, runic_words, count) do
    new_matches =
      Enum.count(runic_words, fn {runic_letters, length} ->
        Enum.take(characters, length) == runic_letters
      end)

    check_for_runic_words(tl(characters), runic_words, count + new_matches)
  end

  def part2(%{runic_words: runic_words, lines: lines}) do
    runic_words =
      Enum.map(runic_words, fn word ->
        word
        |> String.graphemes()
        |> Enum.with_index()
      end)

    Enum.map(lines, fn line ->
      # Each line will be represented as a map eg %{0 => {"A", false}, 1 => {"B", false}, ...}
      # false will be updated to true if it is part of a rune word
      line =
        line
        |> String.graphemes()
        |> Enum.with_index()
        |> Map.new(fn {letter, index} -> {index, {letter, false}} end)

      check_for_rune_symbols(runic_words, line, 0, map_size(line))
    end)
    |> Enum.sum()
  end

  defp check_for_rune_symbols(_runic_words, line, current_char, max_char)
       when current_char > max_char do
    Enum.count(line, fn {_index, {_letter, used}} -> used end)
  end

  # Iterate over the characters in the line, looking forward/backward for every rune word
  defp check_for_rune_symbols(runic_words, line, current_char, max_char) do
    line =
      Enum.reduce(runic_words, line, fn word, line ->
        line
        |> maybe_update_line_with_active_symbols(word, current_char, 1)
        |> maybe_update_line_with_active_symbols(word, current_char, -1)
      end)

    check_for_rune_symbols(runic_words, line, current_char + 1, max_char)
  end

  defp maybe_update_line_with_active_symbols(line, word, current_char, offset) do
    if word_in_line?(line, word, current_char, offset) do
      Enum.reduce(word, line, fn {_letter, index}, line ->
        Map.update!(line, current_char + index * offset, fn {letter, _} -> {letter, true} end)
      end)
    else
      line
    end
  end

  defp word_in_line?(line, word, current_char, offset) do
    Enum.all?(word, fn {letter, index} ->
      case Map.get(line, current_char + index * offset) do
        nil -> false
        {line_letter, _} -> line_letter == letter
      end
    end)
  end

  def parse_input(input) do
    ["WORDS:" <> runic_words | lines] = String.split(input, "\n", trim: true)
    %{runic_words: String.split(runic_words, ","), lines: lines}
  end

  def part1_verify, do: input("part1") |> parse_input() |> part1()
  def part2_verify, do: input("part2") |> parse_input() |> part2()
end
