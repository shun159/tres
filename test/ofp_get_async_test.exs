defmodule OfpGetAsyncTest do
  use ExUnit.Case
  doctest Openflow

  describe "Openflow.GetAsync.Request" do
    test "generate and parse without argument" do
      get_async = Openflow.GetAsync.Request.new()

      get_async
      |> Openflow.to_binary()
      |> Openflow.read()
      |> Kernel.elem(1)
      |> Kernel.==(get_async)
      |> assert()
    end

    test "generate and parse with argument" do
      get_async = Openflow.GetAsync.Request.new(1)

      get_async
      |> Openflow.to_binary()
      |> Openflow.read()
      |> Kernel.elem(1)
      |> Kernel.==(get_async)
      |> assert()
    end
  end

  describe "Openflow.GetAsync.Reply" do
    test "generate and parse without argument" do
      get_async = Openflow.GetAsync.Reply.new()

      get_async
      |> Openflow.to_binary()
      |> Openflow.read()
      |> Kernel.elem(1)
      |> Kernel.==(get_async)
      |> assert()
    end

    test "generate and parse with argument" do
      get_async =
        Openflow.GetAsync.Reply.new(
          flow_removed_mask_master: [:idle_timeout, :hard_timeout, :delete, :group_delete],
          flow_removed_mask_slave: [],
          packet_in_mask_master: [:no_match, :action],
          packet_in_mask_slave: [],
          port_status_mask_master: [:add, :delete, :modify],
          port_status_mask_slave: [:add, :delete, :modify]
        )

      get_async
      |> Openflow.to_binary()
      |> Openflow.read()
      |> Kernel.elem(1)
      |> Kernel.==(get_async)
      |> assert()
    end
  end
end
