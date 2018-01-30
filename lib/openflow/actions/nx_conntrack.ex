defmodule Openflow.Action.NxConntrack do
  import Bitwise

  defstruct(
    flags: [],
    zone_src: nil,
    zone_imm: 0,
    zone_offset: nil,
    zone_n_bits: nil,
    recirc_table: 255,
    alg: 0,
    exec: []
  )

  @experimenter 0x00002320
  @nxast 35

  alias __MODULE__

  def new(options \\ []) do
    %NxConntrack{
      flags: options[:flags] || [],
      zone_src: options[:zone_src],
      zone_imm: options[:zone_imm] || 0,
      zone_offset: options[:zone_offset],
      zone_n_bits: options[:zone_n_bits],
      recirc_table: options[:recirc_table] || 255,
      alg: options[:alg] || 0,
      exec: options[:exec] || []
    }
  end

  def to_binary(%NxConntrack{
        flags: flags,
        zone_src: zone_src,
        zone_offset: zone_ofs,
        zone_n_bits: zone_n_bits,
        zone_imm: zone_imm,
        recirc_table: recirc_table,
        alg: alg,
        exec: exec
      }) do
    flags_int = Openflow.Enums.flags_to_int(flags, :nx_conntrack_flags)

    {src_bin, ofs_nbits} =
      if not is_nil(zone_src) do
        zone_src_bin = Openflow.Match.codec_header(zone_src)
        {zone_src_bin, zone_ofs <<< 6 ||| zone_n_bits - 1}
      else
        {<<0::32>>, zone_imm}
      end

    exec_bin = Openflow.Action.to_binary(exec)

    exp_body =
      <<@experimenter::32, @nxast::16, flags_int::16, src_bin::bytes, ofs_nbits::16,
        recirc_table::8, 0::size(3)-unit(8), alg::16, exec_bin::bytes>>

    exp_body_size = byte_size(exp_body)
    padding_length = Openflow.Utils.padding(4 + exp_body_size, 8)
    length = 4 + exp_body_size + padding_length
    <<0xFFFF::16, length::16, exp_body::bytes, 0::size(padding_length)-unit(8)>>
  end

  def read(
        <<@experimenter::32, @nxast::16, flags_int::16, src_bin::4-bytes, ofs_nbits::16-bits,
          recirc_table::8, _::size(3)-unit(8), alg::16, exec_bin::bytes>>
      ) do
    flags = Openflow.Enums.int_to_flags(flags_int, :nx_conntrack_flags)
    exec = Openflow.Action.read(exec_bin)

    ct = %NxConntrack{
      flags: flags,
      recirc_table: recirc_table,
      alg: alg,
      exec: exec
    }

    case src_bin do
      <<0::32>> ->
        <<zone_imm::16>> = ofs_nbits
        %{ct | zone_imm: zone_imm}

      binary when is_binary(binary) ->
        zone_src = Openflow.Match.codec_header(binary)
        <<ofs::10, n_bits::6>> = ofs_nbits
        %{ct | zone_src: zone_src, zone_offset: ofs, zone_n_bits: n_bits + 1}
    end
  end
end
