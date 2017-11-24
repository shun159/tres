defmodule LearningSwitchTest do
  use ExUnit.Case
  doctest LearningSwitch

  test "greets the world" do
    assert LearningSwitch.hello() == :world
  end
end
