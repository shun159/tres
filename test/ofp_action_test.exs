defmodule OfpActionTest do
  use ExUnit.Case
  doctest Openflow

  describe "Openflow.Action.Output" do
    test "with output:1" do
      output = Openflow.Action.Output.new(1)

      output
      |> Openflow.Action.to_binary()
      |> Openflow.Action.read()
      |> Enum.at(0)
      |> Kernel.==(output)
      |> assert()
    end

    test "with CONTROLLER:65509" do
      output = Openflow.Action.Output.new(port_number: :controller, max_len: :max)

      output
      |> Openflow.Action.to_binary()
      |> Openflow.Action.read()
      |> Enum.at(0)
      |> Kernel.==(output)
      |> assert()
    end

    test "with no port_number option" do
      assert_raise RuntimeError, "port_number must be specified", fn ->
        Openflow.Action.Output.new()
      end
    end
  end

  describe "Openflow.Action.DecMplsTtl" do
    test "with no options" do
      dec_mpls_ttl = Openflow.Action.DecMplsTtl.new()

      dec_mpls_ttl
      |> Openflow.Action.to_binary()
      |> Openflow.Action.read()
      |> Enum.at(0)
      |> Kernel.==(dec_mpls_ttl)
      |> assert()
    end
  end

  describe "Openflow.Action.PushVlan" do
    test "with no options" do
      push_vlan = Openflow.Action.PushVlan.new()

      push_vlan
      |> Openflow.Action.to_binary()
      |> Openflow.Action.read()
      |> Enum.at(0)
      |> Kernel.==(push_vlan)
      |> assert()
    end

    test "with an ethertype" do
      push_vlan = Openflow.Action.PushVlan.new(0x8100)

      push_vlan
      |> Openflow.Action.to_binary()
      |> Openflow.Action.read()
      |> Enum.at(0)
      |> Kernel.==(push_vlan)
      |> assert()
    end
  end

  describe "Openflow.Action.PopVlan" do
    test "with no options" do
      pop_vlan = Openflow.Action.PopVlan.new()

      pop_vlan
      |> Openflow.Action.to_binary()
      |> Openflow.Action.read()
      |> Enum.at(0)
      |> Kernel.==(pop_vlan)
      |> assert()
    end
  end

  describe "Openflow.Action.PushMpls" do
    test "with no options" do
      push_vlan = Openflow.Action.PushMpls.new()

      push_vlan
      |> Openflow.Action.to_binary()
      |> Openflow.Action.read()
      |> Enum.at(0)
      |> Kernel.==(push_vlan)
      |> assert()
    end

    test "with an ethertype" do
      push_vlan = Openflow.Action.PushMpls.new(0x8847)

      push_vlan
      |> Openflow.Action.to_binary()
      |> Openflow.Action.read()
      |> Enum.at(0)
      |> Kernel.==(push_vlan)
      |> assert()
    end
  end

  describe "Openflow.Action.PopMpls" do
    test "with no options" do
      pop_mpls = Openflow.Action.PopMpls.new()

      pop_mpls
      |> Openflow.Action.to_binary()
      |> Openflow.Action.read()
      |> Enum.at(0)
      |> Kernel.==(pop_mpls)
      |> assert()
    end

    test "with an ethertype" do
      pop_mpls = Openflow.Action.PopMpls.new(0x8847)

      pop_mpls
      |> Openflow.Action.to_binary()
      |> Openflow.Action.read()
      |> Enum.at(0)
      |> Kernel.==(pop_mpls)
      |> assert()
    end
  end

  describe "Openflow.Action.SetQueue" do
    test "with set_queue:1" do
      set_queue = Openflow.Action.SetQueue.new(1)

      set_queue
      |> Openflow.Action.to_binary()
      |> Openflow.Action.read()
      |> Enum.at(0)
      |> Kernel.==(set_queue)
      |> assert()
    end
  end

  describe "Openflow.Action.Group" do
    test "with group:1" do
      group = Openflow.Action.Group.new(1)

      group
      |> Openflow.Action.to_binary()
      |> Openflow.Action.read()
      |> Enum.at(0)
      |> Kernel.==(group)
      |> assert()
    end
  end

  describe "Openflow.Action.DecNwTtl" do
    test "with dec_ttl" do
      dec_nw_ttl = Openflow.Action.DecNwTtl.new()

      dec_nw_ttl
      |> Openflow.Action.to_binary()
      |> Openflow.Action.read()
      |> Enum.at(0)
      |> Kernel.==(dec_nw_ttl)
      |> assert()
    end
  end

  describe "Openflow.Action.NxBundle" do
    test "with a binary" do
      test_file = "test/packet_data/nx_bundle.raw"
      packet = File.read!(test_file)
      actions = Openflow.Action.read(packet)

      bundle =
        Openflow.Action.NxBundle.new(
          algorithm: :highest_random_weight,
          hash_field: :eth_src,
          basis: 0,
          slaves: [4, 8]
        )

      actions_bin = Openflow.Action.to_binary(bundle)
      assert actions_bin == packet
      assert actions == [bundle]
    end

    test "with no option" do
      bundle = Openflow.Action.NxBundle.new()
      assert bundle.algorithm == :active_backup
      assert bundle.hash_field == :eth_src
      assert bundle.basis == 0
      assert bundle.n_slaves == 0
      assert bundle.slaves == []
    end
  end

  describe "Openflow.Action.NxBundleLoad" do
    test "with a binary" do
      test_file = "test/packet_data/nx_bundle_load.raw"
      packet = File.read!(test_file)
      actions = Openflow.Action.read(packet)

      bundle_load =
        Openflow.Action.NxBundleLoad.new(
          algorithm: :highest_random_weight,
          hash_field: :eth_src,
          basis: 0,
          slaves: [4, 8],
          offset: 0,
          dst_field: :reg0
        )

      actions_bin = Openflow.Action.to_binary(bundle_load)
      assert actions_bin == packet
      assert actions == [bundle_load]
    end

    test "with no option" do
      assert_raise RuntimeError, "dst_field must be specified", fn ->
        Openflow.Action.NxBundleLoad.new([])
      end
    end
  end

  test "Openflow.Action.NxController" do
    test_file = "test/packet_data/nx_controller.raw"
    packet = File.read!(test_file)
    actions = Openflow.Action.read(packet)

    controller =
      Openflow.Action.NxController.new(
        max_len: 1234,
        reason: :invalid_ttl,
        id: 5678
      )

    actions_bin = Openflow.Action.to_binary(controller)
    assert actions_bin == packet
    assert actions == [controller]
  end

  describe "Openflow.Action.NxController2" do
    test "with packet data" do
      test_file = "test/packet_data/nx_controller2.raw"
      packet = File.read!(test_file)
      actions = Openflow.Action.read(packet)

      controller2 =
        Openflow.Action.NxController2.new(
          max_len: 1234,
          id: 5678,
          reason: :invalid_ttl,
          userdata: <<1, 2, 3, 4, 5>>,
          pause: true,
          meter_id: 0
        )

      assert actions == [controller2]

      controller2
      |> Openflow.Action.NxController2.to_binary()
      |> Openflow.Action.read()
      |> Enum.at(0)
      |> Kernel.==(controller2)
      |> assert()
    end

    test "with meter_id" do
      controller2 =
        [meter_id: 0xFACE]
        |> Openflow.Action.NxController2.new()
        |> Openflow.Action.NxController2.to_binary()
        |> Openflow.Action.read()
        |> Enum.at(0)

      assert controller2.max_len == :no_buffer
      assert controller2.id == 0
      assert controller2.reason == :action
      assert controller2.userdata == ""
      assert controller2.pause == false
      assert controller2.meter_id == 0xFACE
    end

    test "with no options" do
      controller2 =
        Openflow.Action.NxController2.new()
        |> Openflow.Action.NxController2.to_binary()
        |> Openflow.Action.read()
        |> Enum.at(0)

      assert controller2.max_len == :no_buffer
      assert controller2.id == 0
      assert controller2.reason == :action
      assert controller2.userdata == ""
      assert controller2.pause == false
      assert controller2.meter_id == 0
    end
  end

  describe "Openflow.Action.NxConntrack" do
    test "with ct(alg=ftp)" do
      test_file = "test/packet_data/nx_ct(alg=ftp).raw"
      packet = File.read!(test_file)
      actions = Openflow.Action.read(packet)
      ct = Openflow.Action.NxConntrack.new(alg: 21)
      actions_bin = Openflow.Action.to_binary(ct)
      assert actions_bin == packet
      assert actions == [ct]
    end

    test "with ct(alg=tftp)" do
      test_file = "test/packet_data/nx_ct(alg=tftp).raw"
      packet = File.read!(test_file)
      actions = Openflow.Action.read(packet)
      ct = Openflow.Action.NxConntrack.new(alg: 69)
      actions_bin = Openflow.Action.to_binary(ct)
      assert actions_bin == packet
      assert actions == [ct]
    end

    test "with ct(commit)" do
      test_file = "test/packet_data/nx_ct(commit).raw"
      packet = File.read!(test_file)
      actions = Openflow.Action.read(packet)
      ct = Openflow.Action.NxConntrack.new(flags: [:commit])
      actions_bin = Openflow.Action.to_binary(ct)
      assert actions_bin == packet
      assert actions == [ct]
    end

    test "with ct(commit,force)" do
      test_file = "test/packet_data/nx_ct(commit, force).raw"
      packet = File.read!(test_file)
      actions = Openflow.Action.read(packet)
      ct = Openflow.Action.NxConntrack.new(flags: [:commit, :force])
      actions_bin = Openflow.Action.to_binary(ct)
      assert actions_bin == packet
      assert actions == [ct]
    end

    test "with ct(commit,exec(load:0->NXM_NX_CT_LABEL[64..127],load:0x1d->NXM_NX_CT_LABEL[0..63]))" do
      test_file =
        "test/packet_data/nx_ct(commit,exec(load:0->NXM_NX_CT_LABEL[64..127],load:0x1d->NXM_NX_CT_LABEL[0..63])).raw"

      packet = File.read!(test_file)
      actions = Openflow.Action.read(packet)

      ct =
        Openflow.Action.NxConntrack.new(
          flags: [:commit],
          exec: [
            Openflow.Action.NxRegLoad.new(dst_field: :ct_label, value: 0, offset: 64, n_bits: 64),
            Openflow.Action.NxRegLoad.new(dst_field: :ct_label, value: 0x1D, n_bits: 64)
          ]
        )

      actions_bin = Openflow.Action.to_binary(ct)
      assert actions_bin == packet
      assert actions == [ct]
    end

    test "with ct(commit,exec(load:0xf009->NXM_NX_CT_MARK[]))" do
      test_file = "test/packet_data/nx_ct(commit,exec(load:0xf009->NXM_NX_CT_MARK[])).raw"
      packet = File.read!(test_file)
      actions = Openflow.Action.read(packet)

      ct =
        Openflow.Action.NxConntrack.new(
          flags: [:commit],
          exec: [Openflow.Action.NxRegLoad.new(dst_field: :ct_mark, value: 0xF009)]
        )

      actions_bin = Openflow.Action.to_binary(ct)
      assert actions_bin == packet
      assert actions == [ct]
    end

    test "with ct(commit,force,exec(load:0xf009->NXM_NX_CT_MARK[]))" do
      test_file = "test/packet_data/nx_ct(commit,force,exec(load:0xf009->NXM_NX_CT_MARK[])).raw"
      packet = File.read!(test_file)
      actions = Openflow.Action.read(packet)

      ct =
        Openflow.Action.NxConntrack.new(
          flags: [:commit, :force],
          exec: [Openflow.Action.NxRegLoad.new(dst_field: :ct_mark, value: 0xF009)]
        )

      actions_bin = Openflow.Action.to_binary(ct)
      assert actions_bin == packet
      assert actions == [ct]
    end

    test "with ct(commit,nat(dst))" do
      test_file = "test/packet_data/nx_ct(commit,nat(dst)).raw"
      packet = File.read!(test_file)
      actions = Openflow.Action.read(packet)

      ct =
        Openflow.Action.NxConntrack.new(
          flags: [:commit],
          exec: [Openflow.Action.NxNat.new(flags: [:dst])]
        )

      actions_bin = Openflow.Action.to_binary(ct)
      assert actions_bin == packet
      assert actions == [ct]
    end

    test "with ct(commit,nat(dst=10.0.0.128-10.0.0.254,hash))" do
      test_file = "test/packet_data/nx_ct(commit,nat(dst=10.0.0.128-10.0.0.254,hash)).raw"
      packet = File.read!(test_file)
      actions = Openflow.Action.read(packet)
      {:ok, ipv4_min} = :inet.parse_ipv4_address('10.0.0.128')
      {:ok, ipv4_max} = :inet.parse_ipv4_address('10.0.0.254')

      ct =
        Openflow.Action.NxConntrack.new(
          flags: [:commit],
          exec: [
            Openflow.Action.NxNat.new(
              flags: [:dst, :protocol_hash],
              ipv4_min: ipv4_min,
              ipv4_max: ipv4_max
            )
          ]
        )

      actions_bin = Openflow.Action.to_binary(ct)
      assert actions_bin == packet
      assert actions == [ct]
    end

    test "with ct(commit,nat(src))" do
      test_file = "test/packet_data/nx_ct(commit,nat(src)).raw"
      packet = File.read!(test_file)
      actions = Openflow.Action.read(packet)

      ct =
        Openflow.Action.NxConntrack.new(
          flags: [:commit],
          exec: [Openflow.Action.NxNat.new(flags: [:src])]
        )

      actions_bin = Openflow.Action.to_binary(ct)
      assert actions_bin == packet
      assert actions == [ct]
    end

    test "with ct(commit,nat(src=10.0.0.240,random))" do
      test_file = "test/packet_data/nx_ct(commit,nat(src=10.0.0.240,random)).raw"
      packet = File.read!(test_file)
      actions = Openflow.Action.read(packet)
      {:ok, ipv4_min} = :inet.parse_ipv4_address('10.0.0.240')

      ct =
        Openflow.Action.NxConntrack.new(
          flags: [:commit],
          exec: [
            Openflow.Action.NxNat.new(
              flags: [:src, :protocol_random],
              ipv4_min: ipv4_min
            )
          ]
        )

      actions_bin = Openflow.Action.to_binary(ct)
      assert actions_bin == packet
      assert actions == [ct]
    end

    test "with ct(commit,nat(src=10.0.0.240-10.0.0.254:32768-65535,persistent))" do
      test_file =
        "test/packet_data/nx_ct(commit,nat(src=10.0.0.240-10.0.0.254:32768-65535,persistent)).raw"

      packet = File.read!(test_file)
      actions = Openflow.Action.read(packet)
      {:ok, ipv4_min} = :inet.parse_ipv4_address('10.0.0.240')
      {:ok, ipv4_max} = :inet.parse_ipv4_address('10.0.0.254')

      ct =
        Openflow.Action.NxConntrack.new(
          flags: [:commit],
          exec: [
            Openflow.Action.NxNat.new(
              flags: [:src, :persistent],
              ipv4_min: ipv4_min,
              ipv4_max: ipv4_max,
              proto_min: 32_768,
              proto_max: 65_535
            )
          ]
        )

      actions_bin = Openflow.Action.to_binary(ct)
      assert actions_bin == packet
      assert actions == [ct]
    end

    test "with ct(commit,nat(src=10.0.0.240:32768-65535,random))" do
      test_file = "test/packet_data/nx_ct(commit,nat(src=10.0.0.240:32768-65535,random)).raw"
      packet = File.read!(test_file)
      actions = Openflow.Action.read(packet)
      {:ok, ipv4_min} = :inet.parse_ipv4_address('10.0.0.240')

      ct =
        Openflow.Action.NxConntrack.new(
          flags: [:commit],
          exec: [
            Openflow.Action.NxNat.new(
              flags: [:src, :protocol_random],
              ipv4_min: ipv4_min,
              proto_min: 32_768,
              proto_max: 65_535
            )
          ]
        )

      actions_bin = Openflow.Action.to_binary(ct)
      assert actions_bin == packet
      assert actions == [ct]
    end

    test "with ct(commit,nat(src=[fe80::20c:29ff:fe88:1]-[fe80::20c:29ff:fe88:a18b]:255-4096,random))" do
      test_file =
        "test/packet_data/nx_ct(commit,nat(src=[fe80::20c:29ff:fe88:1]-[fe80::20c:29ff:fe88:a18b]:255-4096,random)).raw"

      packet = File.read!(test_file)
      actions = Openflow.Action.read(packet)
      {:ok, ipv6_min} = :inet.parse_ipv6_address('fe80::20c:29ff:fe88:1')
      {:ok, ipv6_max} = :inet.parse_ipv6_address('fe80::20c:29ff:fe88:a18b')

      ct =
        Openflow.Action.NxConntrack.new(
          flags: [:commit],
          exec: [
            Openflow.Action.NxNat.new(
              flags: [:src, :protocol_random],
              ipv6_min: ipv6_min,
              ipv6_max: ipv6_max,
              proto_min: 255,
              proto_max: 4096
            )
          ]
        )

      actions_bin = Openflow.Action.to_binary(ct)
      assert actions_bin == packet
      assert actions == [ct]
    end

    test "with ct(commit,nat(src=fe80::20c:29ff:fe88:1-fe80::20c:29ff:fe88:a18b,random))" do
      test_file =
        "test/packet_data/nx_ct(commit,nat(src=fe80::20c:29ff:fe88:1-fe80::20c:29ff:fe88:a18b,random)).raw"

      packet = File.read!(test_file)
      actions = Openflow.Action.read(packet)
      {:ok, ipv6_min} = :inet.parse_ipv6_address('fe80::20c:29ff:fe88:1')
      {:ok, ipv6_max} = :inet.parse_ipv6_address('fe80::20c:29ff:fe88:a18b')

      ct =
        Openflow.Action.NxConntrack.new(
          flags: [:commit],
          exec: [
            Openflow.Action.NxNat.new(
              flags: [:src, :protocol_random],
              ipv6_min: ipv6_min,
              ipv6_max: ipv6_max
            )
          ]
        )

      actions_bin = Openflow.Action.to_binary(ct)
      assert actions_bin == packet
      assert actions == [ct]
    end

    test "with ct(commit,nat(src=fe80::20c:29ff:fe88:a18b,random))" do
      test_file = "test/packet_data/nx_ct(commit,nat(src=fe80::20c:29ff:fe88:a18b,random)).raw"
      packet = File.read!(test_file)
      actions = Openflow.Action.read(packet)
      {:ok, ipv6_min} = :inet.parse_ipv6_address('fe80::20c:29ff:fe88:a18b')

      ct =
        Openflow.Action.NxConntrack.new(
          flags: [:commit],
          exec: [Openflow.Action.NxNat.new(flags: [:src, :protocol_random], ipv6_min: ipv6_min)]
        )

      actions_bin = Openflow.Action.to_binary(ct)
      assert actions_bin == packet
      assert actions == [ct]
    end

    test "with ct(nat)" do
      test_file = "test/packet_data/nx_ct(nat).raw"
      packet = File.read!(test_file)
      actions = Openflow.Action.read(packet)
      ct = Openflow.Action.NxConntrack.new(exec: [Openflow.Action.NxNat.new()])
      actions_bin = Openflow.Action.to_binary(ct)
      assert actions_bin == packet
      assert actions == [ct]
    end

    test "with ct(table=10)" do
      test_file = "test/packet_data/nx_ct(table=10).raw"
      packet = File.read!(test_file)
      actions = Openflow.Action.read(packet)
      ct = Openflow.Action.NxConntrack.new(recirc_table: 10)
      actions_bin = Openflow.Action.to_binary(ct)
      assert actions_bin == packet
      assert actions == [ct]
    end

    test "with ct(zone=10)" do
      test_file = "test/packet_data/nx_ct(zone=10).raw"
      packet = File.read!(test_file)
      actions = Openflow.Action.read(packet)
      ct = Openflow.Action.NxConntrack.new(zone_imm: 10)
      actions_bin = Openflow.Action.to_binary(ct)
      assert actions_bin == packet
      assert actions == [ct]
    end

    test "with ct(zone=NXM_NX_REG0[0..15])" do
      test_file = "test/packet_data/nx_ct(zone=NXM_NX_REG0[0..15]).raw"
      packet = File.read!(test_file)
      actions = Openflow.Action.read(packet)
      ct = Openflow.Action.NxConntrack.new(zone_src: :reg0, zone_offset: 0, zone_n_bits: 16)
      actions_bin = Openflow.Action.to_binary(ct)
      assert actions_bin == packet
      assert actions == [ct]
    end

    test "with ct" do
      test_file = "test/packet_data/nx_ct.raw"
      packet = File.read!(test_file)
      actions = Openflow.Action.read(packet)
      ct = Openflow.Action.NxConntrack.new()
      actions_bin = Openflow.Action.to_binary(ct)
      assert actions_bin == packet
      assert actions == [ct]
    end
  end

  describe "Openflow.Action.NxCtClear" do
    test "with ct_clear" do
      test_file = "test/packet_data/nx_ct_clear.raw"
      packet = File.read!(test_file)
      actions = Openflow.Action.read(packet)
      ct = Openflow.Action.NxCtClear.new()
      actions_bin = Openflow.Action.to_binary(ct)
      assert actions_bin == packet
      assert actions == [ct]
    end
  end

  describe "Openflow.Action.NxDecTtl" do
    test "with dec_ttl" do
      test_file = "test/packet_data/nx_dec_ttl.raw"
      packet = File.read!(test_file)
      actions = Openflow.Action.read(packet)
      dec_ttl = Openflow.Action.NxDecTtl.new()
      actions_bin = Openflow.Action.to_binary(dec_ttl)
      assert actions_bin == packet
      assert actions == [dec_ttl]
    end
  end

  describe "Openflow.Action.NxDecTtlCntIds" do
    test "with dec_ttl_cnt_ids" do
      test_file = "test/packet_data/nx_dec_ttl_cnt_ids.raw"
      packet = File.read!(test_file)
      actions = Openflow.Action.read(packet)
      dec_ttl = Openflow.Action.NxDecTtlCntIds.new([32_768, 12_345, 90, 765, 1024])
      actions_bin = Openflow.Action.to_binary(dec_ttl)
      assert actions_bin == packet
      assert actions == [dec_ttl]
    end
  end

  describe "Openflow.Action.NxExit" do
    test "with exit" do
      test_file = "test/packet_data/nx_exit.raw"
      packet = File.read!(test_file)
      actions = Openflow.Action.read(packet)
      exit = Openflow.Action.NxExit.new()
      actions_bin = Openflow.Action.to_binary(exit)
      assert actions_bin == packet
      assert actions == [exit]
    end
  end

  describe "Openflow.Action.NxFinTimeout" do
    test "with fin_timeout" do
      test_file = "test/packet_data/nx_fin_timeout.raw"
      packet = File.read!(test_file)
      actions = Openflow.Action.read(packet)
      fin_timeout = Openflow.Action.NxFinTimeout.new(idle_timeout: 10, hard_timeout: 20)
      actions_bin = Openflow.Action.to_binary(fin_timeout)
      assert actions_bin == packet
      assert actions == [fin_timeout]
    end
  end

  describe "Openflow.Action.NxLearn" do
    test "with learn" do
      test_file = "test/packet_data/nx_learn.raw"
      packet = File.read!(test_file)
      actions = Openflow.Action.read(packet)

      learn =
        Openflow.Action.NxLearn.new(
          idle_timeout: 10,
          hard_timeout: 20,
          priority: 80,
          cookie: 0x123456789ABCDEF0,
          flags: [],
          table_id: 2,
          fin_idle_timeout: 2,
          fin_hard_timeout: 4,
          flow_specs: [
            Openflow.Action.NxFlowSpecMatch.new(src: :nx_vlan_tci, dst: :nx_vlan_tci, n_bits: 12),
            Openflow.Action.NxFlowSpecMatch.new(src: :nx_eth_src, dst: :nx_eth_dst),
            Openflow.Action.NxFlowSpecOutput.new(src: :nx_in_port)
          ]
        )

      actions_bin = Openflow.Action.to_binary(learn)
      assert actions_bin == packet
      assert actions == [learn]
    end
  end

  describe "Openflow.Action.NxLearn2" do
    test "with learn2 packet" do
      test_file = "test/packet_data/nx_learn2.raw"
      packet = File.read!(test_file)
      actions = Openflow.Action.read(packet)

      learn2 =
        Openflow.Action.NxLearn2.new(
          idle_timeout: 10,
          hard_timeout: 20,
          priority: 80,
          cookie: 0x123456789ABCDEF0,
          flags: [:write_result],
          table_id: 2,
          fin_idle_timeout: 2,
          fin_hard_timeout: 4,
          limit: 1,
          result_dst: :reg0,
          result_dst_offset: 8,
          flow_specs: [
            Openflow.Action.NxFlowSpecMatch.new(src: :nx_vlan_tci, dst: :nx_vlan_tci, n_bits: 12),
            Openflow.Action.NxFlowSpecMatch.new(src: :nx_eth_src, dst: :nx_eth_dst),
            Openflow.Action.NxFlowSpecOutput.new(src: :nx_in_port)
          ]
        )

      actions_bin = Openflow.Action.to_binary(learn2)
      assert actions_bin == packet
      assert actions == [learn2]
    end

    test "with no options" do
      learn2 = Openflow.Action.NxLearn2.new()

      learn2
      |> Openflow.Action.to_binary()
      |> Openflow.Action.read()
      |> Enum.at(0)
      |> Kernel.==(learn2)
      |> assert()
    end
  end

  describe "Openflow.Action.NxFlowSpecOutput" do
    test "with src = :in_port" do
      flow_spec = Openflow.Action.NxFlowSpecOutput.new(src: :in_port)

      flow_spec
      |> Openflow.Action.NxFlowSpec.to_binary()
      |> Openflow.Action.NxFlowSpec.read()
      |> Enum.at(0)
      |> Kernel.==(flow_spec)
      |> assert()
    end

    test "with no options" do
      assert_raise RuntimeError, ":src must be specified", fn ->
        Openflow.Action.NxFlowSpecOutput.new()
      end
    end
  end

  describe "Openflow.Action.NxFlowSpecMatch" do
    test "with src = 0xdeadbeef and dst: :reg0" do
      flow_spec = Openflow.Action.NxFlowSpecMatch.new(src: 0xDEADBEEF, dst: :reg0)

      flow_spec
      |> Openflow.Action.NxFlowSpec.to_binary()
      |> Openflow.Action.NxFlowSpec.read()
      |> Enum.at(0)
      |> Kernel.==(flow_spec)
      |> assert()
    end

    test "with src = :in_port and dst: :reg0" do
      flow_spec =
        Openflow.Action.NxFlowSpecMatch.new(
          src: :in_port,
          dst: :reg0,
          src_offset: 0,
          dst_offset: 0,
          n_bits: 16
        )

      flow_spec
      |> Openflow.Action.NxFlowSpec.to_binary()
      |> Openflow.Action.NxFlowSpec.read()
      |> Enum.at(0)
      |> Kernel.==(flow_spec)
      |> assert()
    end

    test "with no option" do
      assert_raise RuntimeError, ":dst must be specified", fn ->
        Openflow.Action.NxFlowSpecMatch.new()
      end
    end

    test "with no dst option" do
      assert_raise RuntimeError, ":dst must be specified", fn ->
        Openflow.Action.NxFlowSpecMatch.new(src: :in_port)
      end
    end

    test "with no src option" do
      assert_raise RuntimeError, ":src must be specified", fn ->
        Openflow.Action.NxFlowSpecMatch.new(dst: :reg0)
      end
    end
  end

  describe "Openflow.Action.NxFlowSpecLoad" do
    test "with src = 0xdeadbeef and dst: :reg0" do
      flow_spec = Openflow.Action.NxFlowSpecLoad.new(src: 0xDEADBEEF, dst: :reg0)

      flow_spec
      |> Openflow.Action.NxFlowSpec.to_binary()
      |> Openflow.Action.NxFlowSpec.read()
      |> Enum.at(0)
      |> Kernel.==(flow_spec)
      |> assert()
    end

    test "with src = :in_port and dst: :reg0" do
      flow_spec =
        Openflow.Action.NxFlowSpecLoad.new(
          src: :in_port,
          dst: :reg0,
          src_offset: 0,
          dst_offset: 0,
          n_bits: 16
        )

      flow_spec
      |> Openflow.Action.NxFlowSpec.to_binary()
      |> Openflow.Action.NxFlowSpec.read()
      |> Enum.at(0)
      |> Kernel.==(flow_spec)
      |> assert()
    end

    test "with no dst option" do
      assert_raise RuntimeError, ":dst must be specified", fn ->
        Openflow.Action.NxFlowSpecLoad.new(src: :in_port)
      end
    end

    test "with no src option" do
      assert_raise RuntimeError, ":src must be specified", fn ->
        Openflow.Action.NxFlowSpecLoad.new(dst: :reg0)
      end
    end
  end

  describe "Openflow.Action.NxMultipath" do
    test "with multipath" do
      test_file = "test/packet_data/nx_multipath.raw"
      packet = File.read!(test_file)
      actions = Openflow.Action.read(packet)

      multipath =
        Openflow.Action.NxMultipath.new(
          algorithm: :modulo_n,
          basis: 50,
          dst_field: :reg0
        )

      actions_bin = Openflow.Action.to_binary(multipath)
      assert actions_bin == packet
      assert actions == [multipath]
    end
  end

  describe "Openflow.Action.NxNote" do
    test "with note binary" do
      test_file = "test/packet_data/nx_note.raw"
      packet = File.read!(test_file)
      actions = Openflow.Action.read(packet)
      note = Openflow.Action.NxNote.new(<<0x11, 0xE9, 0x9A, 0xAD, 0x67, 0xF3>>)
      actions_bin = Openflow.Action.to_binary(note)
      assert actions_bin == packet
      assert actions == [note]
    end
  end

  describe "Openflow.Action.NxOutputReg" do
    test "with output_reg options src_field = reg1, n_bits = 6, offset = 5" do
      test_file = "test/packet_data/nx_output_reg.raw"
      packet = File.read!(test_file)
      actions = Openflow.Action.read(packet)
      output_reg = Openflow.Action.NxOutputReg.new(src_field: :reg1, n_bits: 6, offset: 5)
      actions_bin = Openflow.Action.to_binary(output_reg)
      assert actions_bin == packet
      assert actions == [output_reg]
    end
  end

  describe "Openflow.Action.NxOutputReg2" do
    test "with output_reg options src_field = reg1, n_bits = 6, offset = 5" do
      output_reg = Openflow.Action.NxOutputReg2.new(src_field: :reg1, n_bits: 6, offset: 5)

      output_reg
      |> Openflow.Action.to_binary()
      |> Openflow.Action.read()
      |> Enum.at(0)
      |> Kernel.==(output_reg)
      |> assert()
    end
  end

  describe "Openflow.Action.NxOutputTrunc" do
    test "with output_trunc options: packets output to port1 trunc in 100bytes" do
      test_file = "test/packet_data/nx_output_trunc.raw"
      packet = File.read!(test_file)
      actions = Openflow.Action.read(packet)
      output_trunc = Openflow.Action.NxOutputTrunc.new(port_no: 1, max_len: 100)
      actions_bin = Openflow.Action.to_binary(output_trunc)
      assert actions_bin == packet
      assert actions == [output_trunc]
    end
  end

  describe "Openflow.Action.NxRegLoad" do
    test "with options: load 0xf008 to vlan_tci" do
      test_file = "test/packet_data/nx_reg_load.raw"
      packet = File.read!(test_file)
      actions = Openflow.Action.read(packet)
      reg_load = Openflow.Action.NxRegLoad.new(dst_field: :nx_vlan_tci, value: 0xF009)
      actions_bin = Openflow.Action.to_binary(reg_load)
      assert actions_bin == packet
      assert actions == [reg_load]
    end

    test "with no options" do
      assert_raise RuntimeError, "dst_field must be specified", fn ->
        Openflow.Action.NxRegLoad.new()
      end
    end
  end

  describe "Openflow.Action.NxRegMove" do
    test "with options: move in_port value to vlan_tci field" do
      test_file = "test/packet_data/nx_reg_move.raw"
      packet = File.read!(test_file)
      actions = Openflow.Action.read(packet)

      reg_move =
        Openflow.Action.NxRegMove.new(
          src_field: :nx_in_port,
          dst_field: :nx_vlan_tci,
          src_offset: 0,
          dst_offset: 0
        )

      actions_bin = Openflow.Action.to_binary(reg_move)
      assert actions_bin == packet
      assert actions == [reg_move]
    end

    test "with no options" do
      assert_raise RuntimeError, "src_field must be specified", fn ->
        Openflow.Action.NxRegMove.new()
      end
    end

    test "with no dst_field options" do
      assert_raise RuntimeError, "dst_field must be specified", fn ->
        Openflow.Action.NxRegMove.new(src_field: :reg0)
      end
    end
  end

  describe "Openflow.Action.NxResubmit" do
    test "with options: resubmit to table, search with the port_no" do
      test_file = "test/packet_data/nx_resubmit.raw"
      packet = File.read!(test_file)
      actions = Openflow.Action.read(packet)
      resubmit = Openflow.Action.NxResubmit.new(_port_no = 5)
      actions_bin = Openflow.Action.to_binary(resubmit)
      assert actions_bin == packet
      assert actions == [resubmit]
    end
  end

  describe "Openflow.Action.NxResubmitTable" do
    test "with resubmit_table" do
      test_file = "test/packet_data/nx_resubmit_table.raw"
      packet = File.read!(test_file)
      actions = Openflow.Action.read(packet)
      resubmit_table = Openflow.Action.NxResubmitTable.new(in_port: 10, table_id: 5)
      actions_bin = Openflow.Action.to_binary(resubmit_table)
      assert actions_bin == packet
      assert actions == [resubmit_table]
    end
  end

  describe "Openflow.Action.NxResubmitTableCt" do
    test "with resubmit_table_ct" do
      test_file = "test/packet_data/nx_resubmit_table_ct.raw"
      packet = File.read!(test_file)
      actions = Openflow.Action.read(packet)
      resubmit_table_ct = Openflow.Action.NxResubmitTableCt.new(in_port: 10, table_id: 5)
      actions_bin = Openflow.Action.to_binary(resubmit_table_ct)
      assert actions_bin == packet
      assert actions == [resubmit_table_ct]
    end
  end

  describe "Openflow.Action.NxClone" do
    test "with clone(push_vlan:0x8100,set_field:5->vlan_vid,output:10)" do
      test_file = "test/packet_data/nx_clone.raw"
      packet = File.read!(test_file)
      actions = Openflow.Action.read(packet)

      clone =
        Openflow.Action.NxClone.new([
          Openflow.Action.PushVlan.new(),
          Openflow.Action.SetField.new(vlan_vid: 5),
          Openflow.Action.Output.new(10)
        ])

      actions_bin = Openflow.Action.to_binary(clone)
      assert actions_bin == packet
      assert actions == [clone]
    end
  end

  describe "Openflow.Action.NxRegLoad2" do
    test "with set_field:0x1/0x1->reg1" do
      reg_load2 = Openflow.Action.NxRegLoad2.new(reg1: {1, 1})

      reg_load2
      |> Openflow.Action.to_binary()
      |> Openflow.Action.read()
      |> Enum.at(0)
      |> Kernel.==(reg_load2)
      |> assert()
    end

    test "with set_field:0x1->reg1" do
      reg_load2 = Openflow.Action.NxRegLoad2.new(reg1: 1)

      reg_load2
      |> Openflow.Action.to_binary()
      |> Openflow.Action.read()
      |> Enum.at(0)
      |> Kernel.==(reg_load2)
      |> assert()
    end
  end

  describe "Openflow.Action.NxStackPop" do
    test "with pop:NXM_NX_REG0[]" do
      pop = Openflow.Action.NxStackPop.new(field: :reg0)

      assert pop.n_bits == 32
      assert pop.offset == 0

      pop
      |> Openflow.Action.to_binary()
      |> Openflow.Action.read()
      |> Enum.at(0)
      |> Kernel.==(pop)
      |> assert()
    end

    test "with pop:NXM_NX_REG0[1..31]" do
      pop = Openflow.Action.NxStackPop.new(field: :reg0, offset: 1, n_bits: 31)

      assert pop.n_bits == 31
      assert pop.offset == 1

      pop
      |> Openflow.Action.to_binary()
      |> Openflow.Action.read()
      |> Enum.at(0)
      |> Kernel.==(pop)
      |> assert()
    end
  end

  describe "Openflow.Action.NxSetTunnel" do
    test "with set_tunnel:0x1" do
      set_tunnel = Openflow.Action.NxSetTunnel.new(1)

      set_tunnel
      |> Openflow.Action.to_binary()
      |> Openflow.Action.read()
      |> Enum.at(0)
      |> Kernel.==(set_tunnel)
      |> assert()
    end
  end

  describe "Openflow.Action.NxSetTunnel64" do
    test "with set_tunnel64:0x1" do
      set_tunnel = Openflow.Action.NxSetTunnel64.new(1)

      set_tunnel
      |> Openflow.Action.to_binary()
      |> Openflow.Action.read()
      |> Enum.at(0)
      |> Kernel.==(set_tunnel)
      |> assert()
    end
  end

  describe "Openflow.Action.NxWriteMetadata" do
    test "with write_metadata:0x1" do
      write_metadata = Openflow.Action.NxWriteMetadata.new(1)

      write_metadata
      |> Openflow.Action.to_binary()
      |> Openflow.Action.read()
      |> Enum.at(0)
      |> Kernel.==(write_metadata)
      |> assert()
    end

    test "with write_metadata:0x1/0x1" do
      write_metadata = Openflow.Action.NxWriteMetadata.new(metadata: 0x1, metadata_mask: 0x1)

      write_metadata
      |> Openflow.Action.to_binary()
      |> Openflow.Action.read()
      |> Enum.at(0)
      |> Kernel.==(write_metadata)
      |> assert()
    end

    test "with no options" do
      assert_raise RuntimeError, "metadata must be specified", fn ->
        Openflow.Action.NxWriteMetadata.new()
      end
    end
  end

  describe "Openflow.Action.NxConjunction" do
    test "with conjunction(0,1/2)" do
      conjunction = Openflow.Action.NxConjunction.new(clause: 0, n_clauses: 2)

      assert conjunction.id == 0
      assert conjunction.clause == 1
      assert conjunction.n_clauses == 2

      conjunction
      |> Openflow.Action.to_binary()
      |> Openflow.Action.read()
      |> Enum.at(0)
      |> Kernel.==(conjunction)
      |> assert()
    end
  end

  test "with no n_clauses option" do
    assert_raise RuntimeError, "n_clauses must be specified", fn ->
      Openflow.Action.NxConjunction.new(id: 1, clause: 0)
    end
  end

  test "with n_clauses option less than 2" do
    assert_raise RuntimeError, "n_clauses must be greater than 1", fn ->
      Openflow.Action.NxConjunction.new(id: 1, clause: 0, n_clauses: 1)
    end
  end
end
