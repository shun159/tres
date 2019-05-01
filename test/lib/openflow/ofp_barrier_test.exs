defmodule OfpBarrierTest do
  use ExUnit.Case
  doctest Openflow

  describe "Openflow.Barrier.Request" do
    test "generate and parse without argument" do
      barrier = Openflow.Barrier.Request.new()

      barrier
      |> Openflow.to_binary()
      |> Openflow.read()
      |> Kernel.elem(1)
      |> Kernel.==(barrier)
      |> assert()
    end

    test "generate and parse with argument" do
      barrier = Openflow.Barrier.Request.new(1)

      barrier
      |> Openflow.to_binary()
      |> Openflow.read()
      |> Kernel.elem(1)
      |> Kernel.==(barrier)
      |> assert()
    end
  end

  describe "Openflow.Barrier.Reply" do
    test "generate and parse without argument" do
      barrier = Openflow.Barrier.Reply.new()

      barrier
      |> Openflow.to_binary()
      |> Openflow.read()
      |> Kernel.elem(1)
      |> Kernel.==(barrier)
      |> assert()
    end

    test "generate and parse with argument" do
      barrier = Openflow.Barrier.Reply.new(1)

      barrier
      |> Openflow.to_binary()
      |> Openflow.read()
      |> Kernel.elem(1)
      |> Kernel.==(barrier)
      |> assert()
    end
  end
end
