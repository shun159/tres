defmodule Openflow.Match.Field do
  def codec(value0, field) when is_binary(value0) do
    {type, format} = format_of(field)
    n_bits = n_bits_of(field)
    bit_size = bit_size(value0)

    value =
      if bit_size < n_bits do
        head_pad_len = n_bits - bit_size
        <<0::size(head_pad_len), value0::bytes>>
      else
        if bit_size > n_bits and type != :mac do
          head_pad_len = bit_size - n_bits
          <<_::size(head_pad_len), value::size(n_bits)-bits>> = value0
          value
        else
          value0
        end
      end

    formatting(value, type, format)
  end

  def codec(value, type) do
    {type, format} = format_of(type)
    formatting(value, type, format)
  end

  def n_bits_of(field) do
    field
    |> format_of
    |> bit_size_of
  end

  def bit_size_of({:u8, _}), do: 8
  def bit_size_of({:u24, _}), do: 24
  def bit_size_of({:be16, _}), do: 16
  def bit_size_of({:be32, _}), do: 32
  def bit_size_of({:be64, _}), do: 64
  def bit_size_of({:be128, _}), do: 128
  def bit_size_of({:mac, _}), do: 48

  # NXM0
  def vendor_of(:nx_in_port), do: :nxm_0
  def vendor_of(:nx_eth_dst), do: :nxm_0
  def vendor_of(:nx_eth_src), do: :nxm_0
  def vendor_of(:nx_eth_type), do: :nxm_0
  def vendor_of(:nx_vlan_tci), do: :nxm_0
  def vendor_of(:nx_ip_tos), do: :nxm_0
  def vendor_of(:nx_ip_proto), do: :nxm_0
  def vendor_of(:nx_ipv4_src), do: :nxm_0
  def vendor_of(:nx_ipv4_dst), do: :nxm_0
  def vendor_of(:nx_tcp_src), do: :nxm_0
  def vendor_of(:nx_tcp_dst), do: :nxm_0
  def vendor_of(:nx_udp_src), do: :nxm_0
  def vendor_of(:nx_udp_dst), do: :nxm_0
  def vendor_of(:nx_icmpv4_type), do: :nxm_0
  def vendor_of(:nx_icmpv4_code), do: :nxm_0
  def vendor_of(:nx_arp_op), do: :nxm_0
  def vendor_of(:nx_arp_spa), do: :nxm_0
  def vendor_of(:nx_arp_tpa), do: :nxm_0
  def vendor_of(:nx_tcp_flags), do: :nxm_0

  # NXM1
  def vendor_of(:reg0), do: :nxm_1
  def vendor_of(:reg1), do: :nxm_1
  def vendor_of(:reg2), do: :nxm_1
  def vendor_of(:reg3), do: :nxm_1
  def vendor_of(:reg4), do: :nxm_1
  def vendor_of(:reg5), do: :nxm_1
  def vendor_of(:reg6), do: :nxm_1
  def vendor_of(:reg7), do: :nxm_1
  def vendor_of(:reg8), do: :nxm_1
  def vendor_of(:reg9), do: :nxm_1
  def vendor_of(:reg10), do: :nxm_1
  def vendor_of(:reg11), do: :nxm_1
  def vendor_of(:reg12), do: :nxm_1
  def vendor_of(:reg13), do: :nxm_1
  def vendor_of(:reg14), do: :nxm_1
  def vendor_of(:reg15), do: :nxm_1
  def vendor_of(:tun_id), do: :nxm_1
  def vendor_of(:nx_arp_sha), do: :nxm_1
  def vendor_of(:nx_arp_tha), do: :nxm_1
  def vendor_of(:nx_ipv6_src), do: :nxm_1
  def vendor_of(:nx_ipv6_dst), do: :nxm_1
  def vendor_of(:nx_icmpv6_type), do: :nxm_1
  def vendor_of(:nx_icmpv6_code), do: :nxm_1
  def vendor_of(:nx_ipv6_nd_target), do: :nxm_1
  def vendor_of(:nx_ipv6_nd_sll), do: :nxm_1
  def vendor_of(:nx_ipv6_nd_tll), do: :nxm_1
  def vendor_of(:nx_ip_frag), do: :nxm_1
  def vendor_of(:nx_ipv6_label), do: :nxm_1
  def vendor_of(:nx_ip_ecn), do: :nxm_1
  def vendor_of(:nx_ip_ttl), do: :nxm_1
  def vendor_of(:nx_mpls_ttl), do: :nxm_1
  def vendor_of(:tun_src), do: :nxm_1
  def vendor_of(:tun_dst), do: :nxm_1
  def vendor_of(:pkt_mark), do: :nxm_1
  def vendor_of(:dp_hash), do: :nxm_1
  def vendor_of(:recirc_id), do: :nxm_1
  def vendor_of(:conj_id), do: :nxm_1
  def vendor_of(:nx_tun_gbp_id), do: :nxm_1
  def vendor_of(:nx_tun_gbp_flags), do: :nxm_1
  def vendor_of(:tun_metadata0), do: :nxm_1
  def vendor_of(:tun_metadata1), do: :nxm_1
  def vendor_of(:tun_metadata2), do: :nxm_1
  def vendor_of(:tun_metadata3), do: :nxm_1
  def vendor_of(:tun_metadata4), do: :nxm_1
  def vendor_of(:tun_metadata5), do: :nxm_1
  def vendor_of(:tun_metadata6), do: :nxm_1
  def vendor_of(:tun_metadata7), do: :nxm_1
  def vendor_of(:tun_metadata8), do: :nxm_1
  def vendor_of(:tun_metadata9), do: :nxm_1
  def vendor_of(:tun_metadata10), do: :nxm_1
  def vendor_of(:tun_metadata11), do: :nxm_1
  def vendor_of(:tun_metadata12), do: :nxm_1
  def vendor_of(:tun_metadata13), do: :nxm_1
  def vendor_of(:tun_metadata14), do: :nxm_1
  def vendor_of(:tun_metadata15), do: :nxm_1
  def vendor_of(:tun_metadata16), do: :nxm_1
  def vendor_of(:tun_metadata17), do: :nxm_1
  def vendor_of(:tun_metadata18), do: :nxm_1
  def vendor_of(:tun_metadata19), do: :nxm_1
  def vendor_of(:tun_metadata20), do: :nxm_1
  def vendor_of(:tun_metadata21), do: :nxm_1
  def vendor_of(:tun_metadata22), do: :nxm_1
  def vendor_of(:tun_metadata23), do: :nxm_1
  def vendor_of(:tun_metadata24), do: :nxm_1
  def vendor_of(:tun_metadata25), do: :nxm_1
  def vendor_of(:tun_metadata26), do: :nxm_1
  def vendor_of(:tun_metadata27), do: :nxm_1
  def vendor_of(:tun_metadata28), do: :nxm_1
  def vendor_of(:tun_metadata29), do: :nxm_1
  def vendor_of(:tun_metadata30), do: :nxm_1
  def vendor_of(:tun_metadata31), do: :nxm_1
  def vendor_of(:tun_metadata32), do: :nxm_1
  def vendor_of(:tun_metadata33), do: :nxm_1
  def vendor_of(:tun_metadata34), do: :nxm_1
  def vendor_of(:tun_metadata35), do: :nxm_1
  def vendor_of(:tun_metadata36), do: :nxm_1
  def vendor_of(:tun_metadata37), do: :nxm_1
  def vendor_of(:tun_metadata38), do: :nxm_1
  def vendor_of(:tun_metadata39), do: :nxm_1
  def vendor_of(:tun_metadata40), do: :nxm_1
  def vendor_of(:tun_metadata41), do: :nxm_1
  def vendor_of(:tun_metadata42), do: :nxm_1
  def vendor_of(:tun_metadata43), do: :nxm_1
  def vendor_of(:tun_metadata44), do: :nxm_1
  def vendor_of(:tun_metadata45), do: :nxm_1
  def vendor_of(:tun_metadata46), do: :nxm_1
  def vendor_of(:tun_metadata47), do: :nxm_1
  def vendor_of(:tun_metadata48), do: :nxm_1
  def vendor_of(:tun_metadata49), do: :nxm_1
  def vendor_of(:tun_metadata50), do: :nxm_1
  def vendor_of(:tun_metadata51), do: :nxm_1
  def vendor_of(:tun_metadata52), do: :nxm_1
  def vendor_of(:tun_metadata53), do: :nxm_1
  def vendor_of(:tun_metadata54), do: :nxm_1
  def vendor_of(:tun_metadata55), do: :nxm_1
  def vendor_of(:tun_metadata56), do: :nxm_1
  def vendor_of(:tun_metadata57), do: :nxm_1
  def vendor_of(:tun_metadata58), do: :nxm_1
  def vendor_of(:tun_metadata59), do: :nxm_1
  def vendor_of(:tun_metadata60), do: :nxm_1
  def vendor_of(:tun_metadata61), do: :nxm_1
  def vendor_of(:tun_metadata62), do: :nxm_1
  def vendor_of(:tun_metadata63), do: :nxm_1
  def vendor_of(:tun_flags), do: :nxm_1
  def vendor_of(:ct_state), do: :nxm_1
  def vendor_of(:ct_zone), do: :nxm_1
  def vendor_of(:ct_mark), do: :nxm_1
  def vendor_of(:ct_label), do: :nxm_1
  def vendor_of(:tun_ipv6_src), do: :nxm_1
  def vendor_of(:tun_ipv6_dst), do: :nxm_1
  def vendor_of(:xxreg0), do: :nxm_1
  def vendor_of(:xxreg1), do: :nxm_1
  def vendor_of(:xxreg2), do: :nxm_1
  def vendor_of(:xxreg3), do: :nxm_1
  def vendor_of(:xxreg4), do: :nxm_1
  def vendor_of(:xxreg5), do: :nxm_1
  def vendor_of(:xxreg6), do: :nxm_1
  def vendor_of(:xxreg7), do: :nxm_1
  def vendor_of(:ct_ip_proto), do: :nxm_1
  def vendor_of(:ct_ipv4_src), do: :nxm_1
  def vendor_of(:ct_ipv4_dst), do: :nxm_1
  def vendor_of(:ct_ipv6_src), do: :nxm_1
  def vendor_of(:ct_ipv6_dst), do: :nxm_1
  def vendor_of(:ct_tp_src), do: :nxm_1
  def vendor_of(:ct_tp_dst), do: :nxm_1

  # OpenFlow Basic
  def vendor_of(:in_port), do: :openflow_basic
  def vendor_of(:in_phy_port), do: :openflow_basic
  def vendor_of(:metadata), do: :openflow_basic
  def vendor_of(:eth_dst), do: :openflow_basic
  def vendor_of(:eth_src), do: :openflow_basic
  def vendor_of(:eth_type), do: :openflow_basic
  def vendor_of(:vlan_vid), do: :openflow_basic
  def vendor_of(:vlan_pcp), do: :openflow_basic
  def vendor_of(:ip_dscp), do: :openflow_basic
  def vendor_of(:ip_ecn), do: :openflow_basic
  def vendor_of(:ip_proto), do: :openflow_basic
  def vendor_of(:ipv4_src), do: :openflow_basic
  def vendor_of(:ipv4_dst), do: :openflow_basic
  def vendor_of(:tcp_src), do: :openflow_basic
  def vendor_of(:tcp_dst), do: :openflow_basic
  def vendor_of(:udp_src), do: :openflow_basic
  def vendor_of(:udp_dst), do: :openflow_basic
  def vendor_of(:sctp_src), do: :openflow_basic
  def vendor_of(:sctp_dst), do: :openflow_basic
  def vendor_of(:icmpv4_type), do: :openflow_basic
  def vendor_of(:icmpv4_code), do: :openflow_basic
  def vendor_of(:arp_op), do: :openflow_basic
  def vendor_of(:arp_spa), do: :openflow_basic
  def vendor_of(:arp_tpa), do: :openflow_basic
  def vendor_of(:arp_sha), do: :openflow_basic
  def vendor_of(:arp_tha), do: :openflow_basic
  def vendor_of(:ipv6_src), do: :openflow_basic
  def vendor_of(:ipv6_dst), do: :openflow_basic
  def vendor_of(:ipv6_flabel), do: :openflow_basic
  def vendor_of(:icmpv6_type), do: :openflow_basic
  def vendor_of(:icmpv6_code), do: :openflow_basic
  def vendor_of(:ipv6_nd_target), do: :openflow_basic
  def vendor_of(:ipv6_nd_sll), do: :openflow_basic
  def vendor_of(:ipv6_nd_tll), do: :openflow_basic
  def vendor_of(:mpls_label), do: :openflow_basic
  def vendor_of(:mpls_tc), do: :openflow_basic
  def vendor_of(:mpls_bos), do: :openflow_basic
  def vendor_of(:pbb_isid), do: :openflow_basic
  def vendor_of(:tunnel_id), do: :openflow_basic
  def vendor_of(:ipv6_exthdr), do: :openflow_basic
  def vendor_of(:pbb_uca), do: :openflow_basic
  def vendor_of(:packet_type), do: :openflow_basic
  def vendor_of(:gre_flags), do: :openflow_basic
  def vendor_of(:gre_ver), do: :openflow_basic
  def vendor_of(:gre_protocol), do: :openflow_basic
  def vendor_of(:gre_key), do: :openflow_basic
  def vendor_of(:gre_seqnum), do: :openflow_basic
  def vendor_of(:lisp_flags), do: :openflow_basic
  def vendor_of(:lisp_nonce), do: :openflow_basic
  def vendor_of(:lisp_id), do: :openflow_basic
  def vendor_of(:vxlan_flags), do: :openflow_basic
  def vendor_of(:vxlan_vni), do: :openflow_basic
  def vendor_of(:mpls_data_first_nibble), do: :openflow_basic
  def vendor_of(:mpls_ach_version), do: :openflow_basic
  def vendor_of(:mpls_ach_channel), do: :openflow_basic
  def vendor_of(:mpls_pw_metadata), do: :openflow_basic
  def vendor_of(:mpls_cw_flags), do: :openflow_basic
  def vendor_of(:mpls_cw_fragment), do: :openflow_basic
  def vendor_of(:mpls_cw_len), do: :openflow_basic
  def vendor_of(:mpls_cw_seq_num), do: :openflow_basic
  def vendor_of(:gtpu_flags), do: :openflow_basic
  def vendor_of(:gtpu_ver), do: :openflow_basic
  def vendor_of(:gtpu_msg_type), do: :openflow_basic
  def vendor_of(:gtpu_teid), do: :openflow_basic
  def vendor_of(:gtpu_extn_hdr), do: :openflow_basic
  def vendor_of(:gtpu_extn_udp_port), do: :openflow_basic
  def vendor_of(:gtpu_extn_sci), do: :openflow_basic

  # Packet Register
  def vendor_of(:xreg0), do: :packet_register
  def vendor_of(:xreg1), do: :packet_register
  def vendor_of(:xreg2), do: :packet_register
  def vendor_of(:xreg3), do: :packet_register
  def vendor_of(:xreg4), do: :packet_register
  def vendor_of(:xreg5), do: :packet_register
  def vendor_of(:xreg6), do: :packet_register
  def vendor_of(:xreg7), do: :packet_register

  # Nicira Ext Match
  def vendor_of(:nsh_flags), do: :nicira_ext_match
  def vendor_of(:nsh_mdtype), do: :nicira_ext_match
  def vendor_of(:nsh_np), do: :nicira_ext_match
  def vendor_of(:nsh_spi), do: :nicira_ext_match
  def vendor_of(:nsh_si), do: :nicira_ext_match
  def vendor_of(:nsh_c1), do: :nicira_ext_match
  def vendor_of(:nsh_c2), do: :nicira_ext_match
  def vendor_of(:nsh_c3), do: :nicira_ext_match
  def vendor_of(:nsh_c4), do: :nicira_ext_match

  # HP Ext Match
  def vendor_of(:hp_udp_src_port_range), do: :hp_ext_match
  def vendor_of(:hp_udp_dst_port_range), do: :hp_ext_match
  def vendor_of(:hp_tcp_src_port_range), do: :hp_ext_match
  def vendor_of(:hp_tcp_dst_port_range), do: :hp_ext_match
  def vendor_of(:hp_tcp_flags), do: :hp_ext_match
  def vendor_of(:hp_custom_1), do: :hp_ext_match
  def vendor_of(:hp_custom_2), do: :hp_ext_match
  def vendor_of(:hp_custom_3), do: :hp_ext_match
  def vendor_of(:hp_custom_4), do: :hp_ext_match

  # ONF Ext Match
  def vendor_of(:onf_tcp_flags), do: :onf_ext_match
  def vendor_of(:onf_actset_output), do: :onf_ext_match
  def vendor_of(:onf_pbb_uca), do: :onf_ext_match

  # NXM0
  def format_of(:nx_in_port), do: {:be16, :openflow10_port}
  def format_of(:nx_eth_dst), do: {:mac, :ethernet}
  def format_of(:nx_eth_src), do: {:mac, :ethernet}
  def format_of(:nx_eth_type), do: {:be16, :hexadecimal}
  def format_of(:nx_vlan_tci), do: {:be16, :hexadecimal}
  def format_of(:nx_ip_tos), do: {:u8, :decimal}
  def format_of(:nx_ip_proto), do: {:u8, :decimal}
  def format_of(:nx_ipv4_src), do: {:be32, :ipv4}
  def format_of(:nx_ipv4_dst), do: {:be32, :ipv4}
  def format_of(:nx_tcp_src), do: {:be16, :decimal}
  def format_of(:nx_tcp_dst), do: {:be16, :decimal}
  def format_of(:nx_udp_src), do: {:be16, :decimal}
  def format_of(:nx_udp_dst), do: {:be16, :decimal}
  def format_of(:nx_icmpv4_type), do: {:u8, :decimal}
  def format_of(:nx_icmpv4_code), do: {:u8, :decimal}
  def format_of(:nx_arp_op), do: {:be16, :decimal}
  def format_of(:nx_arp_spa), do: {:be32, :ipv4}
  def format_of(:nx_arp_tpa), do: {:be32, :ipv4}
  def format_of(:nx_tcp_flags), do: {:be16, :tcp_flags}

  # NXM1
  def format_of(:reg0), do: {:be32, :hexadecimal}
  def format_of(:reg1), do: {:be32, :hexadecimal}
  def format_of(:reg2), do: {:be32, :hexadecimal}
  def format_of(:reg3), do: {:be32, :hexadecimal}
  def format_of(:reg4), do: {:be32, :hexadecimal}
  def format_of(:reg5), do: {:be32, :hexadecimal}
  def format_of(:reg6), do: {:be32, :hexadecimal}
  def format_of(:reg7), do: {:be32, :hexadecimal}
  def format_of(:reg8), do: {:be32, :hexadecimal}
  def format_of(:reg9), do: {:be32, :hexadecimal}
  def format_of(:reg10), do: {:be32, :hexadecimal}
  def format_of(:reg11), do: {:be32, :hexadecimal}
  def format_of(:reg12), do: {:be32, :hexadecimal}
  def format_of(:reg13), do: {:be32, :hexadecimal}
  def format_of(:reg14), do: {:be32, :hexadecimal}
  def format_of(:reg15), do: {:be32, :hexadecimal}
  def format_of(:tun_id), do: {:be64, :hexadecimal}
  def format_of(:nx_arp_sha), do: {:mac, :ethernet}
  def format_of(:nx_arp_tha), do: {:mac, :ethernet}
  def format_of(:nx_ipv6_src), do: {:be128, :ipv6}
  def format_of(:nx_ipv6_dst), do: {:be128, :ipv6}
  def format_of(:nx_icmpv6_type), do: {:u8, :decimal}
  def format_of(:nx_icmpv6_code), do: {:u8, :decimal}
  def format_of(:nx_ipv6_nd_target), do: {:be128, :ipv6}
  def format_of(:nx_ipv6_nd_sll), do: {:mac, :ethernet}
  def format_of(:nx_ipv6_nd_tll), do: {:mac, :ethernet}
  def format_of(:nx_ip_frag), do: {:u8, :decimal}
  def format_of(:nx_ipv6_label), do: {:be32, :hexadecimal}
  def format_of(:nx_ip_ecn), do: {:u8, :decimal}
  def format_of(:nx_ip_ttl), do: {:u8, :decimal}
  def format_of(:nx_mpls_ttl), do: {:u8, :decimal}
  def format_of(:tun_src), do: {:be32, :ipv4}
  def format_of(:tun_dst), do: {:be32, :ipv4}
  def format_of(:pkt_mark), do: {:be32, :hexadecimal}
  def format_of(:dp_hash), do: {:be32, :hexadecimal}
  def format_of(:recirc_id), do: {:be32, :hexadecimal}
  def format_of(:conj_id), do: {:be32, :hexadecimal}
  def format_of(:nx_tun_gbp_id), do: {:be16, :decimal}
  def format_of(:nx_tun_gbp_flags), do: {:u8, :decimal}
  def format_of(:tun_metadata0), do: {:dynamic, :bytes}
  def format_of(:tun_metadata1), do: {:dynamic, :bytes}
  def format_of(:tun_metadata2), do: {:dynamic, :bytes}
  def format_of(:tun_metadata3), do: {:dynamic, :bytes}
  def format_of(:tun_metadata4), do: {:dynamic, :bytes}
  def format_of(:tun_metadata5), do: {:dynamic, :bytes}
  def format_of(:tun_metadata6), do: {:dynamic, :bytes}
  def format_of(:tun_metadata7), do: {:dynamic, :bytes}
  def format_of(:tun_metadata8), do: {:dynamic, :bytes}
  def format_of(:tun_metadata9), do: {:dynamic, :bytes}
  def format_of(:tun_metadata10), do: {:dynamic, :bytes}
  def format_of(:tun_metadata11), do: {:dynamic, :bytes}
  def format_of(:tun_metadata12), do: {:dynamic, :bytes}
  def format_of(:tun_metadata13), do: {:dynamic, :bytes}
  def format_of(:tun_metadata14), do: {:dynamic, :bytes}
  def format_of(:tun_metadata15), do: {:dynamic, :bytes}
  def format_of(:tun_metadata16), do: {:dynamic, :bytes}
  def format_of(:tun_metadata17), do: {:dynamic, :bytes}
  def format_of(:tun_metadata18), do: {:dynamic, :bytes}
  def format_of(:tun_metadata19), do: {:dynamic, :bytes}
  def format_of(:tun_metadata20), do: {:dynamic, :bytes}
  def format_of(:tun_metadata21), do: {:dynamic, :bytes}
  def format_of(:tun_metadata22), do: {:dynamic, :bytes}
  def format_of(:tun_metadata23), do: {:dynamic, :bytes}
  def format_of(:tun_metadata24), do: {:dynamic, :bytes}
  def format_of(:tun_metadata25), do: {:dynamic, :bytes}
  def format_of(:tun_metadata26), do: {:dynamic, :bytes}
  def format_of(:tun_metadata27), do: {:dynamic, :bytes}
  def format_of(:tun_metadata28), do: {:dynamic, :bytes}
  def format_of(:tun_metadata29), do: {:dynamic, :bytes}
  def format_of(:tun_metadata30), do: {:dynamic, :bytes}
  def format_of(:tun_metadata31), do: {:dynamic, :bytes}
  def format_of(:tun_metadata32), do: {:dynamic, :bytes}
  def format_of(:tun_metadata33), do: {:dynamic, :bytes}
  def format_of(:tun_metadata34), do: {:dynamic, :bytes}
  def format_of(:tun_metadata35), do: {:dynamic, :bytes}
  def format_of(:tun_metadata36), do: {:dynamic, :bytes}
  def format_of(:tun_metadata37), do: {:dynamic, :bytes}
  def format_of(:tun_metadata38), do: {:dynamic, :bytes}
  def format_of(:tun_metadata39), do: {:dynamic, :bytes}
  def format_of(:tun_metadata40), do: {:dynamic, :bytes}
  def format_of(:tun_metadata41), do: {:dynamic, :bytes}
  def format_of(:tun_metadata42), do: {:dynamic, :bytes}
  def format_of(:tun_metadata43), do: {:dynamic, :bytes}
  def format_of(:tun_metadata44), do: {:dynamic, :bytes}
  def format_of(:tun_metadata45), do: {:dynamic, :bytes}
  def format_of(:tun_metadata46), do: {:dynamic, :bytes}
  def format_of(:tun_metadata47), do: {:dynamic, :bytes}
  def format_of(:tun_metadata48), do: {:dynamic, :bytes}
  def format_of(:tun_metadata49), do: {:dynamic, :bytes}
  def format_of(:tun_metadata50), do: {:dynamic, :bytes}
  def format_of(:tun_metadata51), do: {:dynamic, :bytes}
  def format_of(:tun_metadata52), do: {:dynamic, :bytes}
  def format_of(:tun_metadata53), do: {:dynamic, :bytes}
  def format_of(:tun_metadata54), do: {:dynamic, :bytes}
  def format_of(:tun_metadata55), do: {:dynamic, :bytes}
  def format_of(:tun_metadata56), do: {:dynamic, :bytes}
  def format_of(:tun_metadata57), do: {:dynamic, :bytes}
  def format_of(:tun_metadata58), do: {:dynamic, :bytes}
  def format_of(:tun_metadata59), do: {:dynamic, :bytes}
  def format_of(:tun_metadata60), do: {:dynamic, :bytes}
  def format_of(:tun_metadata61), do: {:dynamic, :bytes}
  def format_of(:tun_metadata62), do: {:dynamic, :bytes}
  def format_of(:tun_metadata63), do: {:dynamic, :bytes}
  def format_of(:tun_flags), do: {:be16, :decimal}
  def format_of(:ct_state), do: {:be32, :ct_state}
  def format_of(:ct_zone), do: {:be16, :hexadecimal}
  def format_of(:ct_mark), do: {:be32, :hexadecimal}
  def format_of(:ct_label), do: {:be128, :hexadecimal}
  def format_of(:tun_ipv6_src), do: {:be128, :ipv6}
  def format_of(:tun_ipv6_dst), do: {:be128, :ipv6}
  def format_of(:xxreg0), do: {:be128, :hexadecimal}
  def format_of(:xxreg1), do: {:be128, :hexadecimal}
  def format_of(:xxreg2), do: {:be128, :hexadecimal}
  def format_of(:xxreg3), do: {:be128, :hexadecimal}
  def format_of(:xxreg4), do: {:be128, :hexadecimal}
  def format_of(:xxreg5), do: {:be128, :hexadecimal}
  def format_of(:xxreg6), do: {:be128, :hexadecimal}
  def format_of(:xxreg7), do: {:be128, :hexadecimal}
  def format_of(:ct_ip_proto), do: {:u8, :decimal}
  def format_of(:ct_ipv4_src), do: {:be32, :ipv4}
  def format_of(:ct_ipv4_dst), do: {:be32, :ipv4}
  def format_of(:ct_ipv6_src), do: {:be128, :ipv6}
  def format_of(:ct_ipv6_dst), do: {:be128, :ipv6}
  def format_of(:ct_tp_src), do: {:be16, :decimal}
  def format_of(:ct_tp_dst), do: {:be16, :decimal}

  # OpenFlow Basic
  def format_of(:in_port), do: {:be32, :openflow13_port}
  def format_of(:in_phy_port), do: {:be32, :openflow13_port}
  def format_of(:metadata), do: {:be64, :hexadecimal}
  def format_of(:eth_dst), do: {:mac, :ethernet}
  def format_of(:eth_src), do: {:mac, :ethernet}
  def format_of(:eth_type), do: {:be16, :hexadecimal}
  def format_of(:vlan_vid), do: {:be16, :hexadecimal}
  def format_of(:vlan_pcp), do: {:u8, :decimal}
  def format_of(:ip_dscp), do: {:u8, :decimal}
  def format_of(:ip_ecn), do: {:u8, :decimal}
  def format_of(:ip_proto), do: {:u8, :decimal}
  def format_of(:ipv4_src), do: {:be32, :ipv4}
  def format_of(:ipv4_dst), do: {:be32, :ipv4}
  def format_of(:tcp_src), do: {:be16, :decimal}
  def format_of(:tcp_dst), do: {:be16, :decimal}
  def format_of(:udp_src), do: {:be16, :decimal}
  def format_of(:udp_dst), do: {:be16, :decimal}
  def format_of(:sctp_src), do: {:be16, :decimal}
  def format_of(:sctp_dst), do: {:be16, :decimal}
  def format_of(:icmpv4_type), do: {:u8, :decimal}
  def format_of(:icmpv4_code), do: {:u8, :decimal}
  def format_of(:arp_op), do: {:be16, :decimal}
  def format_of(:arp_spa), do: {:be32, :ipv4}
  def format_of(:arp_tpa), do: {:be32, :ipv4}
  def format_of(:arp_sha), do: {:mac, :ethernet}
  def format_of(:arp_tha), do: {:mac, :ethernet}
  def format_of(:ipv6_src), do: {:be128, :ipv6}
  def format_of(:ipv6_dst), do: {:be128, :ipv6}
  def format_of(:ipv6_flabel), do: {:be32, :hexadecimal}
  def format_of(:icmpv6_type), do: {:u8, :decimal}
  def format_of(:icmpv6_code), do: {:u8, :decimal}
  def format_of(:ipv6_nd_target), do: {:be128, :ipv6}
  def format_of(:ipv6_nd_sll), do: {:mac, :ethernet}
  def format_of(:ipv6_nd_tll), do: {:mac, :ethernet}
  def format_of(:mpls_label), do: {:be32, :decimal}
  def format_of(:mpls_tc), do: {:u8, :decimal}
  def format_of(:mpls_bos), do: {:u8, :decimal}
  def format_of(:pbb_isid), do: {:u24, :decimal}
  def format_of(:tunnel_id), do: {:be64, :hexadecimal}
  def format_of(:ipv6_exthdr), do: {:be16, :ipv6exthdr_flags}
  def format_of(:pbb_uca), do: {:u8, :decimal}
  def format_of(:packet_type), do: {:be32, :decimal}
  def format_of(:gre_flags), do: {:be16, :decimal}
  def format_of(:gre_ver), do: {:u8, :decimal}
  def format_of(:gre_protocol), do: {:be16, :decimal}
  def format_of(:gre_key), do: {:be32, :decimal}
  def format_of(:gre_seqnum), do: {:be32, :decimal}
  def format_of(:lisp_flags), do: {:u8, :decimal}
  def format_of(:lisp_nonce), do: {:u24, :decimal}
  def format_of(:lisp_id), do: {:be32, :decimal}
  def format_of(:vxlan_flags), do: {:u8, :decimal}
  def format_of(:vxlan_vni), do: {:u24, :decimal}
  def format_of(:mpls_data_first_nibble), do: {:u8, :decimal}
  def format_of(:mpls_ach_version), do: {:u8, :decimal}
  def format_of(:mpls_ach_channel), do: {:be16, :decimal}
  def format_of(:mpls_pw_metadata), do: {:u8, :decimal}
  def format_of(:mpls_cw_flags), do: {:u8, :decimal}
  def format_of(:mpls_cw_fragment), do: {:u8, :decimal}
  def format_of(:mpls_cw_len), do: {:u8, :decimal}
  def format_of(:mpls_cw_seq_num), do: {:be16, :decimal}
  def format_of(:gtpu_flags), do: {:u8, :decimal}
  def format_of(:gtpu_ver), do: {:u8, :decimal}
  def format_of(:gtpu_msg_type), do: {:u8, :decimal}
  def format_of(:gtpu_teid), do: {:be32, :decimal}
  def format_of(:gtpu_extn_hdr), do: {:u8, :decimal}
  def format_of(:gtpu_extn_udp_port), do: {:be16, :decimal}
  def format_of(:gtpu_extn_sci), do: {:be16, :decimal}

  # Packet Register
  def format_of(:xreg0), do: {:be64, :hexadecimal}
  def format_of(:xreg1), do: {:be64, :hexadecimal}
  def format_of(:xreg2), do: {:be64, :hexadecimal}
  def format_of(:xreg3), do: {:be64, :hexadecimal}
  def format_of(:xreg4), do: {:be64, :hexadecimal}
  def format_of(:xreg5), do: {:be64, :hexadecimal}
  def format_of(:xreg6), do: {:be64, :hexadecimal}
  def format_of(:xreg7), do: {:be64, :hexadecimal}

  # Nicira Ext Match
  def format_of(:nsh_flags), do: {:u8, :decimal}
  def format_of(:nsh_mdtype), do: {:u8, :decimal}
  def format_of(:nsh_np), do: {:u8, :decimal}
  def format_of(:nsh_spi), do: {:be32, :decimal}
  def format_of(:nsh_si), do: {:be32, :decimal}
  def format_of(:nsh_c1), do: {:be32, :decimal}
  def format_of(:nsh_c2), do: {:be32, :decimal}
  def format_of(:nsh_c3), do: {:be32, :decimal}
  def format_of(:nsh_c4), do: {:be32, :decimal}

  # HP Ext Match
  def format_of(:hp_udp_src_port_range), do: {:be32, :decimal}
  def format_of(:hp_udp_dst_port_range), do: {:be32, :decimal}
  def format_of(:hp_tcp_src_port_range), do: {:be32, :decimal}
  def format_of(:hp_tcp_dst_port_range), do: {:be32, :decimal}
  def format_of(:hp_tcp_flags), do: {:be16, :tcp_flags}
  def format_of(:hp_custom_1), do: {:dynamic, :bytes}
  def format_of(:hp_custom_2), do: {:dynamic, :bytes}
  def format_of(:hp_custom_3), do: {:dynamic, :bytes}
  def format_of(:hp_custom_4), do: {:dynamic, :bytes}

  # ONF Ext Match
  def format_of(:onf_tcp_flags), do: {:be16, :tcp_flags}
  def format_of(:onf_actset_output), do: {:be32, :openflow13_port}
  def format_of(:onf_pbb_uca), do: {:u8, :decimal}

  # Formatting = decimal
  def formatting(<<value::8>>, :u8, :decimal), do: value
  def formatting(value, :u8, :decimal) when is_integer(value), do: <<value::8>>
  def formatting(<<value::16>>, :be16, :decimal), do: value
  def formatting(value, :be16, :decimal) when is_integer(value), do: <<value::16>>
  def formatting(<<value::24>>, :u24, :decimal), do: value
  def formatting(value, :u24, :decimal) when is_integer(value), do: <<value::24>>
  def formatting(<<value::32>>, :be32, :decimal), do: value
  def formatting(value, :be32, :decimal) when is_integer(value), do: <<value::32>>
  def formatting(<<value::64>>, :be64, :decimal), do: value
  def formatting(value, :be64, :decimal) when is_integer(value), do: <<value::64>>
  def formatting(<<value::128>>, :be128, :decimal), do: value
  def formatting(value, :be128, :decimal) when is_integer(value), do: <<value::128>>

  # Formatting = hexadecimal
  def formatting(<<value::16>>, :be16, :hexadecimal), do: value
  def formatting(value, :be16, :hexadecimal) when is_integer(value), do: <<value::16>>

  def formatting(<<value::24>>, :u24, :hexadecimal), do: value
  def formatting(value, :u24, :hexadecimal) when is_integer(value), do: <<value::24>>

  def formatting(<<value::32>>, :be32, :hexadecimal), do: value
  def formatting(value, :be32, :hexadecimal) when is_integer(value), do: <<value::32>>

  def formatting(<<value::64>>, :be64, :hexadecimal), do: value
  def formatting(value, :be64, :hexadecimal) when is_integer(value), do: <<value::64>>

  def formatting(<<value::128>>, :be128, :hexadecimal), do: value
  def formatting(value, :be128, :hexadecimal) when is_integer(value), do: <<value::128>>

  # Formatting = ethernet
  def formatting(<<value::48-bits>>, :mac, :ethernet), do: Openflow.Utils.to_hex_string(value)
  def formatting(value, :mac, :ethernet), do: <<String.to_integer(value, 16)::48>>

  # Formatting = IPv4
  def formatting(<<a1, a2, a3, a4>>, :be32, :ipv4), do: {a1, a2, a3, a4}
  def formatting({a1, a2, a3, a4}, :be32, :ipv4), do: <<a1, a2, a3, a4>>

  # Formatting = IPv6
  def formatting(
        <<a1::16, a2::16, a3::16, a4::16, a5::16, a6::16, a7::16, a8::16>>,
        :be128,
        :ipv6
      ) do
    {a1, a2, a3, a4, a5, a6, a7, a8}
  end

  def formatting({a1, a2, a3, a4, a5, a6, a7, a8}, :be128, :ipv6) do
    <<a1::16, a2::16, a3::16, a4::16, a5::16, a6::16, a7::16, a8::16>>
  end

  # Formatting = OpenFlow 1.0 port
  def formatting(<<value::16>>, :be16, :openflow10_port) do
    try do
      Openflow.Enums.to_atom(value, :openflow10_port_no)
    catch
      :bad_enum -> value
    end
  end

  def formatting(value, :be16, :openflow10_port) do
    port_no =
      try do
        Openflow.Enums.to_int(value, :openflow10_port_no)
      catch
        :bad_enum -> value
      end

    <<port_no::16>>
  end

  # Formatting = OpenFlow 1.3 port
  def formatting(<<value::32>>, :be32, :openflow13_port) do
    try do
      Openflow.Enums.to_atom(value, :openflow13_port_no)
    catch
      :bad_enum -> value
    end
  end

  def formatting(value, :be32, :openflow13_port) do
    port_no =
      try do
        Openflow.Enums.to_int(value, :openflow13_port_no)
      catch
        :bad_enum -> value
      end

    <<port_no::32>>
  end

  # TCP flags
  def formatting(<<value::16>>, :be16, :tcp_flags) do
    Openflow.Enums.int_to_flags(value, :tcp_flags)
  end

  def formatting(value, :be16, :tcp_flags) do
    <<Openflow.Enums.flags_to_int(value, :tcp_flags)::16>>
  end

  # CT State
  def formatting(<<value::32>>, :be32, :ct_state) do
    Openflow.Enums.int_to_flags(value, :ct_state_flags)
  end

  def formatting(value, :be32, :ct_state) do
    <<Openflow.Enums.flags_to_int(value, :ct_state_flags)::32>>
  end

  # CT State
  def formatting(<<value::16>>, :be16, :ipv6exthdr_flags) do
    Openflow.Enums.int_to_flags(value, :ipv6exthdr_flags)
  end

  def formatting(value, :be16, :ipv6exthdr_flags) do
    <<Openflow.Enums.flags_to_int(value, :ipv6exthdr_flags)::16>>
  end

  # Other
  def formatting(value, _, _) do
    value
  end
end
