defmodule ECTest do
  use ExUnit.Case
  doctest EC

  test "greets the world" do
    assert EC.hello() == :world
  end
end
