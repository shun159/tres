defmodule Openflow.Action.NxRegMove do
  defstruct(
    n_bits: 0,
    src_offset: 0,
    dst_offset: 0,
    src_field: nil,
    dst_field: nil
  )

  @experimenter 0x00002320
  @nxast 6

  alias __MODULE__
  alias Openflow.Action.Experimenter

  def new(options \\ []) do
    src_field = options[:src_field] || raise "src_field must be specified"
    dst_field = options[:dst_field] || raise "dst_field must be specified"
    default_n_bits = Openflow.Match.Field.n_bits_of(dst_field)

    %NxRegMove{
      n_bits: options[:n_bits] || default_n_bits,
      src_offset: options[:src_offset] || 0,
      dst_offset: options[:dst_offset] || 0,
      src_field: src_field,
      dst_field: dst_field
    }
  end

  def to_binary(%NxRegMove{} = move) do
    src_field_bin = Openflow.Match.codec_header(move.src_field)
    dst_field_bin = Openflow.Match.codec_header(move.dst_field)

    Experimenter.pack_exp_header(<<
      @experimenter::32,
      @nxast::16,
      move.n_bits::16,
      move.src_offset::16,
      move.dst_offset::16,
      src_field_bin::4-bytes,
      dst_field_bin::4-bytes
    >>)
  end

  def read(<<@experimenter::32, @nxast::16, body::bytes>>) do
    <<n_bits::16, src_ofs::16, dst_ofs::16, src_field_bin::4-bytes, dst_field_bin::4-bytes>> =
      body

    src_field = Openflow.Match.codec_header(src_field_bin)
    dst_field = Openflow.Match.codec_header(dst_field_bin)

    %NxRegMove{
      n_bits: n_bits,
      src_offset: src_ofs,
      dst_offset: dst_ofs,
      src_field: src_field,
      dst_field: dst_field
    }
  end
end
