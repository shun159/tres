defmodule OVSDB.OpenvSwitchTest do
  use ExUnit.Case, async: false

  setup_all do
    {:ok, pid} = OVSDB.start_child("127.0.0.1:6640")
    {:ok, pid: pid}
  end

  describe "OVSDB.OpenvSwitch.find_by_name/3" do
    test "with pid, table and name", context do
      %{"datapath_id" => "0000000000000001"} = OVSDB.OpenvSwitch.find_by_name(context.pid, "Bridge", "br0")
    end
  end

  describe "OVSDB.OpenvSwitch.add_br/2" do
    test "with options", context do
      OVSDB.OpenvSwitch.add_br(
        context.pid,
        name: "brx",
        datapath_id: "0000000000000003"
      )
    end
  end

  describe "OVSDB.OpenvSwitch.set_controller/2" do
    test "with options", context do
      OVSDB.OpenvSwitch.add_br(
        context.pid,
        name: "brx",
        target: "tcp:127.0.0.1:6653",
        connection_mode: "out-of-band",
        controller_rate_limit: 100,
        controller_burst_limit: 25,
        protocol: "OpenFlow13"
      )
    end
  end

  describe "OVSDB.OpenvSwitch.del_br/2" do
    test "with pid and name", context do
      OVSDB.OpenvSwitch.del_br(context.pid, "brx")
    end
  end
end
