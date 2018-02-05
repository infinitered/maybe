defmodule MaybeTest do
  use ExUnit.Case
  doctest Maybe

  test "greets the world" do
    assert Maybe.hello() == :world
  end
end
