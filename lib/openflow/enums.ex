defmodule Openflow.Enums do
  import Bitwise

  @enums [
    openflow_codec: [
      {Openflow.Hello, 0},
      {Openflow.ErrorMsg, 1},
      {Openflow.Echo.Request, 2},
      {Openflow.Echo.Reply, 3},
      {Openflow.Experimenter, 4},
      {Openflow.Features.Request, 5},
      {Openflow.Features.Reply, 6},
      {Openflow.GetConfig.Request, 7},
      {Openflow.GetConfig.Reply, 8},
      {Openflow.SetConfig, 9},
      {Openflow.PacketIn, 10},
      {Openflow.FlowRemoved, 11},
      {Openflow.PortStatus, 12},
      {Openflow.PacketOut, 13},
      {Openflow.FlowMod, 14},
      {Openflow.GroupMod, 15},
      {Openflow.PortMod, 16},
      {Openflow.TableMod, 17},
      {Openflow.Multipart.Request, 18},
      {Openflow.Multipart.Reply, 19},
      {Openflow.Barrier.Request, 20},
      {Openflow.Barrier.Reply, 21},
      {Openflow.Role.Request, 24},
      {Openflow.Role.Reply, 25},
      {Openflow.GetAsync.Request, 26},
      {Openflow.GetAsync.Reply, 27},
      {Openflow.SetAsync, 28},
      {Openflow.MeterMod, 29}
    ],
    experimenter_id: [
      nicira_ext_message: 0x00002320,
      onf_ext_message: 0x4F4E4600
    ],
    nicira_ext_message: [
      # {Openflow.NxRole.Request,        10}, /* Openflow 1.3 support role request/reply */
      # {Openflow.NxRole.Reply,          11},
      # {Openflow.NxSetFlowFormat,       12}, /* No special reason for implement this struct codec. */
      # {Openflow.NxFlowMod,             13}, /* Prefer use ofp_flow_mod to nx_flow_mod */
      # {Openflow.NxFlowRemoved,         14}, /* Prefer use ofp_flow_removed to nx_flow_removed */
      # {Openflow.NxSetFlowModTableId,   15}, /* OpenFlow 1.3 support multiple flow table. */
      {Openflow.NxSetPacketInFormat, 16},
      # {Openflow.NxPacketIn,            17}, /* No special reason for implement this struct codec. */
      # {Openflow.NxFlowAge,             18}, /* No special reason for implement this struct codec. */
      # {Openflow.NxSetAsyncConfig,      19}, /* Openflow 1.3 support async config. */
      {Openflow.NxSetControllerId, 20},
      {Openflow.NxFlowMonitor.Cancel, 21},
      {Openflow.NxFlowMonitor.Paused, 22},
      {Openflow.NxFlowMonitor.Resumed, 23},
      {Openflow.NxTLVTableMod, 24},
      {Openflow.NxTLVTable.Request, 25},
      {Openflow.NxTLVTable.Reply, 26},
      {Openflow.NxSetAsyncConfig2, 27},
      {Openflow.NxResume, 28},
      {Openflow.NxCtFlushZone, 29},
      {Openflow.NxPacketIn2, 30}
    ],
    onf_ext_message: [
      {Openflow.OnfBundleControl, 2300},
      {Openflow.OnfBundleAddMessage, 2301}
    ],
    multipart_request_flags: [
      more: 1 <<< 0
    ],
    multipart_reply_flags: [
      more: 1 <<< 0
    ],
    multipart_request_codec: [
      {Openflow.Multipart.Desc.Request, 0},
      {Openflow.Multipart.Flow.Request, 1},
      {Openflow.Multipart.Aggregate.Request, 2},
      {Openflow.Multipart.Table.Request, 3},
      {Openflow.Multipart.PortStats.Request, 4},
      {Openflow.Multipart.Queue.Request, 5},
      {Openflow.Multipart.Group.Request, 6},
      {Openflow.Multipart.GroupDesc.Request, 7},
      {Openflow.Multipart.GroupFeatures.Request, 8},
      {Openflow.Multipart.Meter.Request, 9},
      {Openflow.Multipart.MeterConfig.Request, 10},
      {Openflow.Multipart.MeterFeatures.Request, 11},
      {Openflow.Multipart.TableFeatures.Request, 12},
      {Openflow.Multipart.PortDesc.Request, 13},
      {Openflow.Multipart.Experimenter.Request, 0xFFFF}
    ],
    multipart_reply_codec: [
      {Openflow.Multipart.Desc.Reply, 0},
      {Openflow.Multipart.Flow.Reply, 1},
      {Openflow.Multipart.Aggregate.Reply, 2},
      {Openflow.Multipart.Table.Reply, 3},
      {Openflow.Multipart.PortStats.Reply, 4},
      {Openflow.Multipart.Queue.Reply, 5},
      {Openflow.Multipart.Group.Reply, 6},
      {Openflow.Multipart.GroupDesc.Reply, 7},
      {Openflow.Multipart.GroupFeatures.Reply, 8},
      {Openflow.Multipart.Meter.Reply, 9},
      {Openflow.Multipart.MeterConfig.Reply, 10},
      {Openflow.Multipart.MeterFeatures.Reply, 11},
      {Openflow.Multipart.TableFeatures.Reply, 12},
      {Openflow.Multipart.PortDesc.Reply, 13},
      {Openflow.Multipart.Experimenter.Reply, 0xFFFF}
    ],
    nicira_ext_stats: [
      {Openflow.Multipart.NxFlow, 0},
      {Openflow.Multipart.NxAggregate, 1},
      {Openflow.Multipart.NxFlowMonitor, 2},
      {Openflow.Multipart.NxIPFIXBridge, 3},
      {Openflow.Multipart.NxIPFIXFlow, 4}
    ],
    hello_elem: [
      versionbitmap: 1
    ],
    error_type: [
      hello_failed: 0,
      bad_request: 1,
      bad_action: 2,
      bad_instruction: 3,
      bad_match: 4,
      flow_mod_failed: 5,
      group_mod_failed: 6,
      port_mod_failed: 7,
      table_mod_failed: 8,
      queue_op_failed: 9,
      switch_config_failed: 10,
      role_request_failed: 11,
      meter_mod_failed: 12,
      table_features_failed: 13,
      experimenter: 0xFFFF
    ],
    hello_failed: [
      inconpatible: 0,
      eperm: 1
    ],
    bad_request: [
      bad_version: 0,
      bad_type: 1,
      bad_multipart: 2,
      bad_experimeter: 3,
      bad_exp_type: 4,
      eperm: 5,
      bad_len: 6,
      buffer_empty: 7,
      buffer_unknown: 8,
      bad_table_id: 9,
      is_slave: 10,
      bad_port: 11,
      bad_packet: 12,
      multipart_buffer_overflow: 13
    ],
    bad_action: [
      bad_type: 0,
      bad_len: 1,
      bad_experimeter: 2,
      bad_exp_type: 3,
      bad_out_port: 4,
      bad_argument: 5,
      eperm: 6,
      too_many: 7,
      bad_queue: 8,
      bad_out_group: 9,
      match_inconsistent: 10,
      unsupported_order: 11,
      bad_tag: 12,
      bad_set_type: 13,
      bad_set_len: 14,
      bad_set_argument: 15
    ],
    bad_instruction: [
      unknown_instruction: 0,
      unsupported_instruction: 1,
      bad_table_id: 2,
      unsupported_metadata: 3,
      unsupported_metadata_mask: 4,
      bad_experimeter: 5,
      bad_exp_type: 6,
      bad_len: 7,
      eperm: 8
    ],
    bad_match: [
      bad_type: 0,
      bad_len: 1,
      bad_tag: 2,
      bad_dl_addr_mask: 3,
      bad_nw_addr_mask: 4,
      bad_wildcards: 5,
      bad_field: 6,
      bad_value: 7,
      bad_mask: 8,
      bad_prereq: 9,
      dup_field: 10,
      eperm: 11
    ],
    flow_mod_failed: [
      unknown: 0,
      table_full: 1,
      bad_table_id: 2,
      overlap: 3,
      eperm: 4,
      bad_timeout: 5,
      bad_command: 6,
      bad_flags: 7
    ],
    group_mod_failed: [
      group_exists: 0,
      invalid_group: 1,
      weight_unsupported: 2,
      out_of_groups: 3,
      ouf_of_buckets: 4,
      chaining_unsupported: 5,
      watch_unsupported: 6,
      loop: 7,
      unknown_group: 8,
      chained_group: 9,
      bad_type: 10,
      bad_command: 11,
      bad_bucket: 12,
      bad_watch: 13,
      eperm: 14
    ],
    port_mod_failed: [
      bad_port: 0,
      bad_hw_addr: 1,
      bad_config: 2,
      bad_advertise: 3,
      eperm: 4
    ],
    table_mod_failed: [
      bad_table: 0,
      bad_config: 1,
      eperm: 2
    ],
    queue_op_failed: [
      bad_port: 0,
      bad_queue: 1,
      eperm: 2
    ],
    switch_config_failed: [
      bad_flags: 0,
      bad_len: 1,
      eperm: 2
    ],
    role_request_failed: [
      stale: 0,
      unsup: 1,
      bad_role: 2
    ],
    meter_mod_failed: [
      unknown: 0,
      meter_exists: 1,
      invalid_meter: 2,
      unknown_meter: 3,
      bad_command: 4,
      bad_flags: 5,
      bad_rate: 6,
      bad_burst: 7,
      bad_band: 8,
      bad_band_value: 9,
      out_of_meters: 10,
      out_of_bands: 11
    ],
    table_features_failed: [
      bad_table: 0,
      bad_metadata: 1,
      bad_type: 2,
      bad_len: 3,
      bad_argument: 4,
      eperm: 5
    ],
    switch_capabilities: [
      flow_stats: 1 <<< 0,
      table_stats: 1 <<< 1,
      port_stats: 1 <<< 2,
      group_stats: 1 <<< 3,
      ip_reasm: 1 <<< 5,
      queue_stats: 1 <<< 6,
      arp_match_ip: 1 <<< 7,
      port_blocked: 1 <<< 8
    ],
    config_flags: [
      drop: 1 <<< 0,
      reasm: 1 <<< 1
    ],
    controller_max_len: [
      max: 0xFFE5,
      no_buffer: 0xFFFF
    ],
    experimenter_oxm_vendors: [
      nicira_ext_match: 0x00002320,
      hp_ext_match: 0x00002428,
      onf_ext_match: 0x4F4E4600
    ],
    match_type: [
      standard: 0,
      oxm: 1
    ],
    oxm_class: [
      nxm_0: 0x0000,
      nxm_1: 0x0001,
      openflow_basic: 0x8000,
      packet_register: 0x8001,
      experimenter: 0xFFFF
    ],
    nxm_0: [
      nx_in_port: 0,
      nx_eth_dst: 1,
      nx_eth_src: 2,
      nx_eth_type: 3,
      nx_vlan_tci: 4,
      nx_ip_tos: 5,
      nx_ip_proto: 6,
      nx_ipv4_src: 7,
      nx_ipv4_dst: 8,
      nx_tcp_src: 9,
      nx_tcp_dst: 10,
      nx_udp_src: 11,
      nx_udp_dst: 12,
      nx_icmpv4_type: 13,
      nx_icmpv4_code: 14,
      nx_arp_op: 15,
      nx_arp_spa: 16,
      nx_arp_tpa: 17,
      nx_tcp_flags: 34
    ],
    nxm_1: [
      reg0: 0,
      reg1: 1,
      reg2: 2,
      reg3: 3,
      reg4: 4,
      reg5: 5,
      reg6: 6,
      reg7: 7,
      reg8: 8,
      reg9: 9,
      reg10: 10,
      reg11: 11,
      reg12: 12,
      reg13: 13,
      reg14: 14,
      reg15: 15,
      tun_id: 16,
      nx_arp_sha: 17,
      nx_arp_tha: 18,
      nx_ipv6_src: 19,
      nx_ipv6_dst: 20,
      nx_icmpv6_type: 21,
      nx_icmpv6_code: 22,
      nx_ipv6_nd_target: 23,
      nx_ipv6_nd_sll: 24,
      nx_ipv6_nd_tll: 25,
      nx_ip_frag: 26,
      nx_ipv6_label: 27,
      nx_ip_ecn: 28,
      nx_ip_ttl: 29,
      nx_mpls_ttl: 30,
      tun_src: 31,
      tun_dst: 32,
      pkt_mark: 33,
      dp_hash: 35,
      recirc_id: 36,
      conj_id: 37,
      tun_gbp_id: 38,
      tun_gbp_flags: 39,
      tun_metadata0: 40,
      tun_metadata1: 41,
      tun_metadata2: 42,
      tun_metadata3: 43,
      tun_metadata4: 44,
      tun_metadata5: 45,
      tun_metadata6: 46,
      tun_metadata7: 47,
      tun_metadata8: 48,
      tun_metadata9: 49,
      tun_metadata10: 50,
      tun_metadata11: 51,
      tun_metadata12: 52,
      tun_metadata13: 53,
      tun_metadata14: 54,
      tun_metadata15: 55,
      tun_metadata16: 56,
      tun_metadata17: 57,
      tun_metadata18: 58,
      tun_metadata19: 59,
      tun_metadata20: 60,
      tun_metadata21: 61,
      tun_metadata22: 62,
      tun_metadata23: 63,
      tun_metadata24: 64,
      tun_metadata25: 65,
      tun_metadata26: 66,
      tun_metadata27: 67,
      tun_metadata28: 68,
      tun_metadata29: 69,
      tun_metadata30: 70,
      tun_metadata31: 71,
      tun_metadata32: 72,
      tun_metadata33: 73,
      tun_metadata34: 74,
      tun_metadata35: 75,
      tun_metadata36: 76,
      tun_metadata37: 77,
      tun_metadata38: 78,
      tun_metadata39: 79,
      tun_metadata40: 80,
      tun_metadata41: 81,
      tun_metadata42: 82,
      tun_metadata43: 83,
      tun_metadata44: 84,
      tun_metadata45: 85,
      tun_metadata46: 86,
      tun_metadata47: 87,
      tun_metadata48: 88,
      tun_metadata49: 89,
      tun_metadata50: 90,
      tun_metadata51: 91,
      tun_metadata52: 92,
      tun_metadata53: 93,
      tun_metadata54: 94,
      tun_metadata55: 95,
      tun_metadata56: 96,
      tun_metadata57: 97,
      tun_metadata58: 98,
      tun_metadata59: 99,
      tun_metadata60: 100,
      tun_metadata61: 101,
      tun_metadata62: 102,
      tun_metadata63: 103,
      tun_flags: 104,
      ct_state: 105,
      ct_zone: 106,
      ct_mark: 107,
      ct_label: 108,
      tun_ipv6_src: 109,
      tun_ipv6_dst: 110,
      xxreg0: 111,
      xxreg1: 112,
      xxreg2: 113,
      xxreg3: 114,
      xxreg4: 115,
      xxreg5: 116,
      xxreg6: 117,
      xxreg7: 118,
      ct_nw_proto: 119,
      ct_nw_src: 120,
      ct_nw_dst: 121,
      ct_ipv6_src: 122,
      ct_ipv6_dst: 123,
      ct_tp_src: 124,
      ct_tp_dst: 125
    ],
    openflow_basic: [
      in_port: 0,
      in_phy_port: 1,
      metadata: 2,
      eth_dst: 3,
      eth_src: 4,
      eth_type: 5,
      vlan_vid: 6,
      vlan_pcp: 7,
      ip_dscp: 8,
      ip_ecn: 9,
      ip_proto: 10,
      ipv4_src: 11,
      ipv4_dst: 12,
      tcp_src: 13,
      tcp_dst: 14,
      udp_src: 15,
      udp_dst: 16,
      sctp_src: 17,
      sctp_dst: 18,
      icmpv4_type: 19,
      icmpv4_code: 20,
      arp_op: 21,
      arp_spa: 22,
      arp_tpa: 23,
      arp_sha: 24,
      arp_tha: 25,
      ipv6_src: 26,
      ipv6_dst: 27,
      ipv6_flabel: 28,
      icmpv6_type: 29,
      icmpv6_code: 30,
      ipv6_nd_target: 31,
      ipv6_nd_sll: 32,
      ipv6_nd_tll: 33,
      mpls_label: 34,
      mpls_tc: 35,
      mpls_bos: 36,
      pbb_isid: 37,
      tunnel_id: 38,
      ipv6_exthdr: 39,

      # Lagopus extended match fields
      pbb_uca: 41,
      packet_type: 42,
      gre_flags: 43,
      gre_ver: 44,
      gre_protocol: 45,
      gre_key: 46,
      gre_seqnum: 47,
      lisp_flags: 48,
      lisp_nonce: 49,
      lisp_id: 50,
      vxlan_flags: 51,
      vxlan_vni: 52,
      mpls_data_first_nibble: 53,
      mpls_ach_version: 54,
      mpls_ach_channel: 55,
      mpls_pw_metadata: 56,
      mpls_cw_flags: 57,
      mpls_cw_fragment: 58,
      mpls_cw_len: 59,
      mpls_cw_seq_num: 60,
      gtpu_flags: 61,
      gtpu_ver: 62,
      gtpu_msg_type: 63,
      gtpu_teid: 64,
      gtpu_extn_hdr: 65,
      gtpu_extn_udp_port: 66,
      gtpu_extn_sci: 67
    ],
    vlan_id: [
      present: 0x1000,
      none: 0x0000
    ],
    ipv6exthdr_flags: [
      nonext: 1 <<< 0,
      esp: 1 <<< 1,
      auth: 1 <<< 2,
      dest: 1 <<< 3,
      frag: 1 <<< 4,
      router: 1 <<< 5,
      hop: 1 <<< 6,
      unrep: 1 <<< 7,
      unseq: 1 <<< 8
    ],
    tcp_flags: [
      fin: 1 <<< 0,
      syn: 1 <<< 1,
      rst: 1 <<< 2,
      psh: 1 <<< 3,
      ack: 1 <<< 4,
      urg: 1 <<< 5,
      ece: 1 <<< 6,
      cwr: 1 <<< 7,
      ns: 1 <<< 8
    ],
    ct_state_flags: [
      # Beginning of a new connection.
      new: 1 <<< 0,
      # Part of an existing connection.
      est: 1 <<< 1,
      # Related to an established connection.
      rel: 1 <<< 2,
      # Flow is in the reply direction.
      rep: 1 <<< 3,
      # Could not track connection.
      inv: 1 <<< 4,
      # Conntrack has occurred.
      trk: 1 <<< 5,
      # Packet's source address/port was mangled by NAT.
      snat: 1 <<< 6,
      # Packet's destination address/port was mangled by NAT.
      dnat: 1 <<< 7
    ],
    packet_register: [
      xreg0: 0,
      xreg1: 1,
      xreg2: 2,
      xreg3: 3,
      xreg4: 4,
      xreg5: 5,
      xreg6: 6,
      xreg7: 7
    ],
    nicira_ext_match: [
      nsh_flags: 1,
      nsh_mdtype: 2,
      nsh_np: 3,
      nsh_spi: 4,
      nsh_si: 5,
      nsh_c1: 6,
      nsh_c2: 7,
      nsh_c3: 8,
      nsh_c4: 9
    ],
    hp_ext_match: [
      hp_udp_src_port_range: 0,
      hp_udp_dst_port_range: 1,
      hp_tcp_src_port_range: 2,
      hp_tcp_dst_port_range: 3,
      hp_tcp_flags: 4,
      hp_custom_1: 5,
      hp_custom_2: 6,
      hp_custom_3: 7,
      hp_custom_4: 8
    ],
    hp_custom_match_type: [
      l2_start: 1,
      l3_start: 2,
      l4_start: 3
    ],
    onf_ext_match: [
      onf_tcp_flags: 42,
      onf_actset_output: 43,
      onf_pbb_uca: 2560
    ],
    packet_in_reason: [
      no_match: 0,
      action: 1,
      invalid_ttl: 2
    ],
    buffer_id: [
      no_buffer: 0xFFFFFFFF
    ],
    port_config: [
      port_down: 1 <<< 0,
      no_receive: 1 <<< 2,
      no_forward: 1 <<< 5,
      no_packet_in: 1 <<< 6
    ],
    port_state: [
      link_down: 1 <<< 0,
      blocked: 1 <<< 1,
      live: 1 <<< 2
    ],
    port_features: [
      {:"10mb_hd", 1 <<< 0},
      {:"10mb_fd", 1 <<< 1},
      {:"100mb_hd", 1 <<< 2},
      {:"100mb_fd", 1 <<< 3},
      {:"1gb_hd", 1 <<< 4},
      {:"1gb_fd", 1 <<< 5},
      {:"10gb_fd", 1 <<< 6},
      {:"40gb_fd", 1 <<< 7},
      {:"100gb_fd", 1 <<< 8},
      {:"1tb_fd", 1 <<< 9},
      {:other, 1 <<< 10},
      {:copper, 1 <<< 11},
      {:fiber, 1 <<< 12},
      {:autoneg, 1 <<< 13},
      {:pause, 1 <<< 14},
      {:pause_asym, 1 <<< 15}
    ],
    openflow10_port_no: [
      max: 0xFF00,
      in_port: 0xFFF8,
      table: 0xFFF9,
      normal: 0xFFFA,
      flood: 0xFFFB,
      all: 0xFFFC,
      controller: 0xFFFD,
      local: 0xFFFE,
      none: 0xFFFF
    ],
    openflow13_port_no: [
      max: 0xFFFFFF00,
      in_port: 0xFFFFFFF8,
      table: 0xFFFFFFF9,
      normal: 0xFFFFFFFA,
      flood: 0xFFFFFFFB,
      all: 0xFFFFFFFC,
      controller: 0xFFFFFFFD,
      local: 0xFFFFFFFE,
      any: 0xFFFFFFFF
    ],
    packet_in_reason: [
      no_match: 0,
      action: 1,
      invalid_ttl: 2,
      action_set: 3,
      group: 4,
      packet_out: 5
    ],
    flow_mod_command: [
      add: 0,
      modify: 1,
      modify_strict: 2,
      delete: 3,
      delete_strict: 4
    ],
    flow_mod_flags: [
      send_flow_rem: 1 <<< 0,
      check_overlap: 1 <<< 1,
      reset_counts: 1 <<< 2,
      no_packet_counts: 1 <<< 3,
      no_byte_counts: 1 <<< 4
    ],
    flow_removed_reason: [
      idle_timeout: 0,
      hard_timeout: 1,
      delete: 2,
      group_delete: 3,
      meter_delete: 4,
      eviction: 5
    ],
    port_reason: [
      add: 0,
      delete: 1,
      modify: 2
    ],
    group_mod_command: [
      add: 0,
      modify: 1,
      delete: 2
    ],
    group_type: [
      all: 0,
      select: 1,
      indirect: 2,
      fast_failover: 3
    ],
    group_id: [
      max: 0xFFFFFF00,
      all: 0xFFFFFFFC,
      any: 0xFFFFFFFF
    ],
    group_capabilities: [
      select_weight: 1 <<< 0,
      select_liveness: 1 <<< 1,
      chaining: 1 <<< 2,
      chaining_checks: 1 <<< 3
    ],
    table_id: [
      max: 0xFE,
      all: 0xFF
    ],
    queue_id: [
      all: 0xFFFFFFFF
    ],
    meter_mod_command: [
      add: 0,
      modify: 1,
      delete: 2
    ],
    meter_id: [
      max: 0xFFFF0000,
      slowpath: 0xFFFFFFFD,
      controller: 0xFFFFFFFE,
      all: 0xFFFFFFFF
    ],
    meter_flags: [
      kbps: 1 <<< 0,
      pktps: 1 <<< 1,
      burst: 1 <<< 2,
      stats: 1 <<< 3
    ],
    meter_band_type: [
      {Openflow.MeterBand.Drop, 1},
      {Openflow.MeterBand.Remark, 2},
      {Openflow.MeterBand.Experimenter, 0xFFFF}
    ],
    table_config: [
      table_miss_controller: 0 <<< 0,
      table_miss_continue: 1 <<< 0,
      table_miss_drop: 2 <<< 0,
      table_miss_mask: 3 <<< 0,
      eviction: 1 <<< 2,
      vacancy_events: 1 <<< 3
    ],
    action_type: [
      {Openflow.Action.Output, 0},
      {Openflow.Action.CopyTtlOut, 11},
      {Openflow.Action.CopyTtlIn, 12},
      {Openflow.Action.SetMplsTtl, 15},
      {Openflow.Action.DecMplsTtl, 16},
      {Openflow.Action.PushVlan, 17},
      {Openflow.Action.PopVlan, 18},
      {Openflow.Action.PushMpls, 19},
      {Openflow.Action.PopMpls, 20},
      {Openflow.Action.SetQueue, 21},
      {Openflow.Action.Group, 22},
      {Openflow.Action.SetNwTtl, 23},
      {Openflow.Action.DecNwTtl, 24},
      {Openflow.Action.SetField, 25},
      {Openflow.Action.PushPbb, 26},
      {Openflow.Action.PopPbb, 27},
      {Openflow.Action.Encap, 28},
      {Openflow.Action.Decap, 29},
      {Openflow.Action.SetSequence, 30},
      {Openflow.Action.ValidateSequence, 31},
      {Openflow.Action.Experimenter, 0xFFFF}
    ],
    action_vendor: [
      nicira_ext_action: 0x00002320,
      onf_ext_action: 0x4F4E4600
    ],
    onf_ext_action: [
      {Openflow.Action.OnfCopyField, 3200}
    ],
    nicira_ext_action: [
      {Openflow.Action.NxResubmit, 1},
      {Openflow.Action.NxSetTunnel, 2},
      {Openflow.Action.NxSetQueue, 4},
      {Openflow.Action.NxPopQueue, 5},
      {Openflow.Action.NxRegMove, 6},
      {Openflow.Action.NxRegLoad, 7},
      {Openflow.Action.NxNote, 8},
      {Openflow.Action.NxSetTunnel64, 9},
      {Openflow.Action.NxMultipath, 10},
      {Openflow.Action.NxBundle, 12},
      {Openflow.Action.NxBundleLoad, 13},
      {Openflow.Action.NxResubmitTable, 14},
      {Openflow.Action.NxOutputReg, 15},
      {Openflow.Action.NxLearn, 16},
      {Openflow.Action.NxExit, 17},
      {Openflow.Action.NxDecTtl, 18},
      {Openflow.Action.NxFinTimeout, 19},
      {Openflow.Action.NxController, 20},
      {Openflow.Action.NxDecTtlCntIds, 21},
      {Openflow.Action.NxWriteMetadata, 22},
      {Openflow.Action.NxPushMpls, 23},
      {Openflow.Action.NxPopMpls, 24},
      {Openflow.Action.NxSetMplsTtl, 25},
      {Openflow.Action.NxDecMplsTtl, 26},
      {Openflow.Action.NxStackPush, 27},
      {Openflow.Action.NxStackPop, 28},
      {Openflow.Action.NxSample, 29},
      {Openflow.Action.NxSetMplsLabel, 30},
      {Openflow.Action.NxSetMplsTc, 31},
      {Openflow.Action.NxOutputReg2, 32},
      {Openflow.Action.NxRegLoad2, 33},
      {Openflow.Action.NxConjunction, 34},
      {Openflow.Action.NxConntrack, 35},
      {Openflow.Action.NxNat, 36},
      {Openflow.Action.NxController2, 37},
      {Openflow.Action.NxSample2, 38},
      {Openflow.Action.NxOutputTrunc, 39},
      {Openflow.Action.NxGroup, 40},
      {Openflow.Action.NxSample3, 41},
      {Openflow.Action.NxClone, 42},
      {Openflow.Action.NxCtClear, 43},
      {Openflow.Action.NxResubmitTableCt, 44},
      {Openflow.Action.NxLearn2, 45},
      {Openflow.Action.NxEncap, 46},
      {Openflow.Action.NxDecap, 47},
      {Openflow.Action.NxDebugRecirc, 0xFF}
    ],
    nx_mp_algorithm: [
      modulo_n: 0,
      hash_threshold: 1,
      highest_random_weight: 2,
      iterative_hash: 3
    ],
    nx_hash_fields: [
      eth_src: 0,
      symmetric_l4: 1,
      symmetric_l3l4: 2,
      symmetric_l3l4_udp: 3,
      nw_src: 4,
      nw_dst: 5
    ],
    nx_bd_algorithm: [
      active_backup: 0,
      highest_random_weight: 1
    ],
    nx_learn_flag: [
      send_flow_rem: 1 <<< 0,
      delete_learned: 1 <<< 1,
      write_result: 1 <<< 2
    ],
    nx_conntrack_flags: [
      commit: 1 <<< 0,
      force: 1 <<< 1
    ],
    nx_nat_flags: [
      src: 1 <<< 0,
      dst: 1 <<< 1,
      persistent: 1 <<< 2,
      protocol_hash: 1 <<< 3,
      protocol_random: 1 <<< 4
    ],
    nx_nat_range: [
      ipv4_min: 1 <<< 0,
      ipv4_max: 1 <<< 1,
      ipv6_min: 1 <<< 2,
      ipv6_max: 1 <<< 3,
      proto_min: 1 <<< 4,
      proto_max: 1 <<< 5
    ],
    nx_action_controller2_prop_type: [
      max_len: 0,
      controller_id: 1,
      reason: 2,
      userdata: 3,
      pause: 4
    ],
    nx_action_sample_direction: [
      default: 0,
      ingress: 1,
      egress: 2
    ],
    nx_flow_spec_type: [
      {Openflow.Action.NxFlowSpecMatch, 0},
      {Openflow.Action.NxFlowSpecLoad, 1},
      {Openflow.Action.NxFlowSpecOutput, 2}
    ],
    instruction_type: [
      {Openflow.Instruction.GotoTable, 1},
      {Openflow.Instruction.WriteMetadata, 2},
      {Openflow.Instruction.WriteActions, 3},
      {Openflow.Instruction.ApplyActions, 4},
      {Openflow.Instruction.ClearActions, 5},
      {Openflow.Instruction.Meter, 6},
      {Openflow.Instruction.Experimenter, 0xFFFF}
    ],
    controller_role: [
      nochange: 0,
      equal: 1,
      master: 2,
      slave: 3
    ],
    nx_role: [
      other: 0,
      master: 1,
      slave: 2
    ],
    packet_in_format: [
      standard: 0,
      nxt_packet_in: 1,
      nxt_packet_in2: 2
    ],
    flow_format: [
      openflow10: 0,
      nxm: 1
    ],
    packet_in2_prop_type: [
      packet: 0,
      full_len: 1,
      buffer_id: 2,
      table_id: 3,
      cookie: 4,
      reason: 5,
      metadata: 6,
      userdata: 7,
      continuation: 8
    ],
    continuation_prop_type: [
      bridge: 0x8000,
      stack: 0x8001,
      mirrors: 0x8002,
      conntracked: 0x8003,
      table_id: 0x8004,
      cookie: 0x8005,
      actions: 0x8006,
      action_set: 0x8007
    ],
    flow_monitor_flag: [
      initial: 1 <<< 0,
      add: 1 <<< 1,
      delete: 1 <<< 2,
      modify: 1 <<< 3,
      actions: 1 <<< 4,
      own: 1 <<< 5
    ],
    flow_update_event: [
      added: 0,
      deleted: 1,
      modified: 2,
      abbrev: 3
    ],
    tlv_table_mod_command: [
      add: 0,
      delete: 1,
      clear: 2
    ],
    table_feature_prop_type: [
      instructions: 0,
      instructions_miss: 1,
      next_tables: 2,
      next_tables_miss: 3,
      write_actions: 4,
      write_actions_miss: 5,
      apply_actions: 6,
      apply_actions_miss: 7,
      match: 8,
      wildcards: 10,
      write_setfield: 12,
      write_setfield_miss: 13,
      apply_setfield: 14,
      apply_setfield_miss: 15,
      experimenter: 0xFFFE,
      experimenter_miss: 0xFFFF
    ]
  ]

  for {enum_name, enum_def} <- @enums do
    enum_name = to_string(enum_name)

    to_int_fn_name = String.to_atom(enum_name <> "_to_int")
    to_atom_fn_name = String.to_atom(enum_name <> "_to_atom")

    for {key, _value} <- enum_def do
      def to_int(unquote(key), unquote(String.to_atom(enum_name))) do
        try do
          unquote(to_int_fn_name)(unquote(key))
        catch
          :throw, _ -> unquote(key)
        end
      end
    end

    for {_key, value} <- enum_def do
      def to_atom(unquote(value), unquote(String.to_atom(enum_name))) do
        try do
          unquote(to_atom_fn_name)(unquote(value))
        catch
          :throw, _ -> unquote(value)
        end
      end
    end

    def to_int(_int, unquote(String.to_atom(enum_name))) do
      throw(:bad_enum)
    end

    def to_atom(_, unquote(String.to_atom(enum_name))) do
      throw(:bad_enum)
    end

    for {key, value} <- enum_def do
      def unquote(to_int_fn_name)(unquote(key)), do: unquote(value)
    end

    def unquote(to_int_fn_name)(_), do: throw(:bad_enum)

    for {key, value} <- enum_def do
      def unquote(to_atom_fn_name)(unquote(value)), do: unquote(key)
    end

    def unquote(to_atom_fn_name)(_), do: throw(:bad_enum)

    def int_to_flags(int, unquote(String.to_atom(enum_name))) do
      Openflow.Utils.int_to_flags([], int, enum_of(unquote(String.to_atom(enum_name))))
    end

    def flags_to_int(flags, unquote(String.to_atom(enum_name))) do
      Openflow.Utils.flags_to_int(0, flags, enum_of(unquote(String.to_atom(enum_name))))
    end

    defp enum_of(unquote(String.to_atom(enum_name))), do: unquote(enum_def)
  end
end
