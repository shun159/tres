defmodule OfpActionTest do
  use ExUnit.Case
  doctest Openflow

  test "Openflow.Action.NxBundle" do
    test_file = "test/packet_data/nx_bundle.raw"
    packet = File.read!(test_file)
    actions = Openflow.Action.read(packet)
    bundle =
      Openflow.Action.NxBundle.new(
        algorithm: :highest_random_weight,
        slaves:    [4, 8]
      )
    actions_bin = Openflow.Action.to_binary(bundle)
    assert actions_bin == packet
    assert actions == [bundle]
  end

  test "Openflow.Action.NxBundleLoad" do
    test_file = "test/packet_data/nx_bundle_load.raw"
    packet = File.read!(test_file)
    actions = Openflow.Action.read(packet)
    bundle_load =
      Openflow.Action.NxBundleLoad.new(
        algorithm: :highest_random_weight,
        slaves: [4, 8],
        dst_field: :reg0
      )
    actions_bin = Openflow.Action.to_binary(bundle_load)
    assert actions_bin == packet
    assert actions == [bundle_load]
  end

  test "Openflow.Action.NxController" do
    test_file = "test/packet_data/nx_controller.raw"
    packet = File.read!(test_file)
    actions = Openflow.Action.read(packet)
    controller = Openflow.Action.NxController.new(
      max_len: 1234,
      reason: :invalid_ttl,
      id: 5678
    )
    actions_bin = Openflow.Action.to_binary(controller)
    assert actions_bin == packet
    assert actions == [controller]
  end

  test "Openflow.Action.NxController2" do
    test_file = "test/packet_data/nx_controller2.raw"
    packet = File.read!(test_file)
    actions = Openflow.Action.read(packet)
    controller2 = Openflow.Action.NxController2.new(
      max_len: 1234,
      reason: :invalid_ttl,
      userdata: <<1,2,3,4,5>>,
      pause: true
    )
    assert actions == [controller2]
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
      ct = Openflow.Action.NxConntrack.new(
        flags: [:commit],
        exec: [Openflow.Action.NxRegLoad.new(dst_field: :ct_label, value: 0, offset: 64, n_bits: 64),
               Openflow.Action.NxRegLoad.new(dst_field: :ct_label, value: 0x1d, n_bits: 64)]
      )
      actions_bin = Openflow.Action.to_binary(ct)
      assert actions_bin == packet
      assert actions == [ct]
    end

    test "with ct(commit,exec(load:0xf009->NXM_NX_CT_MARK[]))" do
      test_file = "test/packet_data/nx_ct(commit,exec(load:0xf009->NXM_NX_CT_MARK[])).raw"
      packet = File.read!(test_file)
      actions = Openflow.Action.read(packet)
      ct = Openflow.Action.NxConntrack.new(
        flags: [:commit],
        exec: [Openflow.Action.NxRegLoad.new(dst_field: :ct_mark, value: 0xf009)]
      )
      actions_bin = Openflow.Action.to_binary(ct)
      assert actions_bin == packet
      assert actions == [ct]
    end

    test "with ct(commit,force,exec(load:0xf009->NXM_NX_CT_MARK[]))" do
      test_file = "test/packet_data/nx_ct(commit,force,exec(load:0xf009->NXM_NX_CT_MARK[])).raw"
      packet = File.read!(test_file)
      actions = Openflow.Action.read(packet)
      ct = Openflow.Action.NxConntrack.new(
        flags: [:commit, :force],
        exec: [Openflow.Action.NxRegLoad.new(dst_field: :ct_mark, value: 0xf009)]
      )
      actions_bin = Openflow.Action.to_binary(ct)
      assert actions_bin == packet
      assert actions == [ct]
    end

    test "with ct(commit,nat(dst))" do
      test_file = "test/packet_data/nx_ct(commit,nat(dst)).raw"
      packet = File.read!(test_file)
      actions = Openflow.Action.read(packet)
      ct = Openflow.Action.NxConntrack.new(
        flags: [:commit],
        exec:  [Openflow.Action.NxNat.new(flags: [:dst])]
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
      ct = Openflow.Action.NxConntrack.new(
        flags: [:commit],
        exec:  [
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
      ct = Openflow.Action.NxConntrack.new(
        flags: [:commit],
        exec:  [Openflow.Action.NxNat.new(flags: [:src])]
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
      ct = Openflow.Action.NxConntrack.new(
        flags: [:commit],
        exec:  [
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
      test_file = "test/packet_data/nx_ct(commit,nat(src=10.0.0.240-10.0.0.254:32768-65535,persistent)).raw"
      packet = File.read!(test_file)
      actions = Openflow.Action.read(packet)
      {:ok, ipv4_min} = :inet.parse_ipv4_address('10.0.0.240')
      {:ok, ipv4_max} = :inet.parse_ipv4_address('10.0.0.254')
      ct = Openflow.Action.NxConntrack.new(
        flags: [:commit],
        exec:  [
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
      ct = Openflow.Action.NxConntrack.new(
        flags: [:commit],
        exec:  [
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
      test_file = "test/packet_data/nx_ct(commit,nat(src=[fe80::20c:29ff:fe88:1]-[fe80::20c:29ff:fe88:a18b]:255-4096,random)).raw"
      packet = File.read!(test_file)
      actions = Openflow.Action.read(packet)
      {:ok, ipv6_min} = :inet.parse_ipv6_address('fe80::20c:29ff:fe88:1')
      {:ok, ipv6_max} = :inet.parse_ipv6_address('fe80::20c:29ff:fe88:a18b')
      ct = Openflow.Action.NxConntrack.new(
        flags: [:commit],
        exec:  [
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
      test_file = "test/packet_data/nx_ct(commit,nat(src=fe80::20c:29ff:fe88:1-fe80::20c:29ff:fe88:a18b,random)).raw"
      packet = File.read!(test_file)
      actions = Openflow.Action.read(packet)
      {:ok, ipv6_min} = :inet.parse_ipv6_address('fe80::20c:29ff:fe88:1')
      {:ok, ipv6_max} = :inet.parse_ipv6_address('fe80::20c:29ff:fe88:a18b')
      ct = Openflow.Action.NxConntrack.new(
        flags: [:commit],
        exec:  [
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
      ct = Openflow.Action.NxConntrack.new(
        flags: [:commit],
        exec:  [Openflow.Action.NxNat.new(flags: [:src, :protocol_random], ipv6_min: ipv6_min)]
      )
      actions_bin = Openflow.Action.to_binary(ct)
      assert actions_bin == packet
      assert actions == [ct]
    end

    test "with ct(nat)" do
      test_file = "test/packet_data/nx_ct(nat).raw"
      packet = File.read!(test_file)
      actions = Openflow.Action.read(packet)
      ct = Openflow.Action.NxConntrack.new(exec:  [Openflow.Action.NxNat.new])
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
      ct = Openflow.Action.NxConntrack.new
      actions_bin = Openflow.Action.to_binary(ct)
      assert actions_bin == packet
      assert actions == [ct]
    end

    test "with ct_clear" do
      test_file = "test/packet_data/nx_ct_clear.raw"
      packet = File.read!(test_file)
      actions = Openflow.Action.read(packet)
      ct = Openflow.Action.NxCtClear.new
      actions_bin = Openflow.Action.to_binary(ct)
      assert actions_bin == packet
      assert actions == [ct]
    end

    test "with dec_ttl" do
      test_file = "test/packet_data/nx_dec_ttl.raw"
      packet = File.read!(test_file)
      actions = Openflow.Action.read(packet)
      dec_ttl = Openflow.Action.NxDecTtl.new
      actions_bin = Openflow.Action.to_binary(dec_ttl)
      assert actions_bin == packet
      assert actions == [dec_ttl]
    end

    test "with dec_ttl_cnt_ids" do
      test_file = "test/packet_data/nx_dec_ttl_cnt_ids.raw"
      packet = File.read!(test_file)
      actions = Openflow.Action.read(packet)
      dec_ttl = Openflow.Action.NxDecTtlCntIds.new([32_768, 12_345, 90, 765, 1024])
      actions_bin = Openflow.Action.to_binary(dec_ttl)
      assert actions_bin == packet
      assert actions == [dec_ttl]
    end

    test "with exit" do
      test_file = "test/packet_data/nx_exit.raw"
      packet = File.read!(test_file)
      actions = Openflow.Action.read(packet)
      exit = Openflow.Action.NxExit.new
      actions_bin = Openflow.Action.to_binary(exit)
      assert actions_bin == packet
      assert actions == [exit]
    end

    test "with fin_timeout" do
      test_file = "test/packet_data/nx_fin_timeout.raw"
      packet = File.read!(test_file)
      actions = Openflow.Action.read(packet)
      fin_timeout = Openflow.Action.NxFinTimeout.new(idle_timeout: 10, hard_timeout: 20)
      actions_bin = Openflow.Action.to_binary(fin_timeout)
      assert actions_bin == packet
      assert actions == [fin_timeout]
    end

    test "with learn" do
      test_file = "test/packet_data/nx_learn.raw"
      packet = File.read!(test_file)
      actions = Openflow.Action.read(packet)
      learn = Openflow.Action.NxLearn.new(
        idle_timeout: 10,
        hard_timeout: 20,
        priority:     80,
        cookie: 0x123456789abcdef0,
        flags:           [],
        table_id:         2,
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

    test "with learn2" do
      test_file = "test/packet_data/nx_learn2.raw"
      packet = File.read!(test_file)
      actions = Openflow.Action.read(packet)
      learn2 = Openflow.Action.NxLearn2.new(
        idle_timeout: 10,
        hard_timeout: 20,
        priority:     80,
        cookie: 0x123456789abcdef0,
        flags:           [:write_result],
        table_id:         2,
        fin_idle_timeout: 2,
        fin_hard_timeout: 4,
        limit:            1,
        result_dst:   :reg0,
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

    test "with multipath" do
      test_file = "test/packet_data/nx_multipath.raw"
      packet = File.read!(test_file)
      actions = Openflow.Action.read(packet)
      multipath = Openflow.Action.NxMultipath.new(
        algorithm: :modulo_n,
        basis: 50,
        dst_field: :reg0
      )
      actions_bin = Openflow.Action.to_binary(multipath)
      assert actions_bin == packet
      assert actions == [multipath]
    end

    test "with note" do
      test_file = "test/packet_data/nx_note.raw"
      packet = File.read!(test_file)
      actions = Openflow.Action.read(packet)
      note = Openflow.Action.NxNote.new(<<0x11, 0xe9, 0x9a, 0xad, 0x67, 0xf3>>)
      actions_bin = Openflow.Action.to_binary(note)
      assert actions_bin == packet
      assert actions == [note]
    end

    test "with output_reg" do
      test_file = "test/packet_data/nx_output_reg.raw"
      packet = File.read!(test_file)
      actions = Openflow.Action.read(packet)
      output_reg = Openflow.Action.NxOutputReg.new(src_field: :reg1, n_bits: 6, offset: 5)
      actions_bin = Openflow.Action.to_binary(output_reg)
      assert actions_bin == packet
      assert actions == [output_reg]
    end

    test "with output_trunc" do
      test_file = "test/packet_data/nx_output_trunc.raw"
      packet = File.read!(test_file)
      actions = Openflow.Action.read(packet)
      output_trunc = Openflow.Action.NxOutputTrunc.new(port_number: 1, max_len: 100)
      actions_bin = Openflow.Action.to_binary(output_trunc)
      assert actions_bin == packet
      assert actions == [output_trunc]
    end

    test "with pop_queue" do
      test_file = "test/packet_data/nx_pop_queue.raw"
      packet = File.read!(test_file)
      actions = Openflow.Action.read(packet)
      pop_queue = Openflow.Action.NxPopQueue.new
      actions_bin = Openflow.Action.to_binary(pop_queue)
      assert actions_bin == packet
      assert actions == [pop_queue]
    end

    test "with reg_load" do
      test_file = "test/packet_data/nx_reg_load.raw"
      packet = File.read!(test_file)
      actions = Openflow.Action.read(packet)
      reg_load = Openflow.Action.NxRegLoad.new(dst_field: :nx_vlan_tci, value: 0xf009)
      actions_bin = Openflow.Action.to_binary(reg_load)
      assert actions_bin == packet
      assert actions == [reg_load]
    end

    test "with reg_move" do
      test_file = "test/packet_data/nx_reg_move.raw"
      packet = File.read!(test_file)
      actions = Openflow.Action.read(packet)
      reg_move = Openflow.Action.NxRegMove.new(src_field: :nx_in_port, dst_field: :nx_vlan_tci)
      actions_bin = Openflow.Action.to_binary(reg_move)
      assert actions_bin == packet
      assert actions == [reg_move]
    end

    test "with resubmit" do
      test_file = "test/packet_data/nx_resubmit.raw"
      packet = File.read!(test_file)
      actions = Openflow.Action.read(packet)
      resubmit = Openflow.Action.NxResubmit.new(5)
      actions_bin = Openflow.Action.to_binary(resubmit)
      assert actions_bin == packet
      assert actions == [resubmit]
    end

    test "with resubmit_table" do
      test_file = "test/packet_data/nx_resubmit_table.raw"
      packet = File.read!(test_file)
      actions = Openflow.Action.read(packet)
      resubmit_table = Openflow.Action.NxResubmitTable.new(in_port: 10, table_id: 5)
      actions_bin = Openflow.Action.to_binary(resubmit_table)
      assert actions_bin == packet
      assert actions == [resubmit_table]
    end

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
end
