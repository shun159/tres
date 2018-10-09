defmodule SimpleRouterTest do
  use ExUnit.Case
  doctest SimpleRouter

  test "greets the world" do
    assert SimpleRouter.hello() == :world
  end
end
