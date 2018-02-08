defmodule LeaderExampleTest do
  use ExUnit.Case
  doctest LeaderExample

  test "greets the world" do
    assert LeaderExample.hello() == :world
  end
end
