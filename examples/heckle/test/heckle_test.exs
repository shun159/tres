defmodule HeckleTest do
  use ExUnit.Case
  doctest Heckle

  test "greets the world" do
    assert Heckle.hello() == :world
  end
end
