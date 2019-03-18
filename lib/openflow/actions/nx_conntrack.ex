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
  alias Openflow.Action.Experimenter

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

  def to_binary(%NxConntrack{} = ct) do
    flags_int = Openflow.Enums.flags_to_int(ct.flags, :nx_conntrack_flags)
    ct_context_bin = ct_context_binary(ct)
    exec_bin = Openflow.Action.to_binary(ct.exec)

    Experimenter.pack_exp_header(<<
      @experimenter::32,
      @nxast::16,
      flags_int::16,
      ct_context_bin::bytes,
      ct.recirc_table::8,
      0::size(3)-unit(8),
      ct.alg::16,
      exec_bin::bytes
    >>)
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

  # private functions

  defp ct_context_binary(%NxConntrack{zone_src: nil} = ct),
    do: <<0::32, ct.zone_imm::16>>

  defp ct_context_binary(%NxConntrack{} = ct) do
    zone_src_bin = Openflow.Match.codec_header(ct.zone_src)
    ofs_nbits = ct.zone_offset <<< 6 ||| ct.zone_n_bits - 1
    <<zone_src_bin::bytes, ofs_nbits::16>>
  end
end
