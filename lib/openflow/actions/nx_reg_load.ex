defmodule Openflow.Action.NxRegLoad do
  import Bitwise

  defstruct(
    n_bits: 0,
    offset: 0,
    dst_field: nil,
    value: nil
  )

  @experimenter 0x00002320
  @nxast 7

  alias __MODULE__
  alias Openflow.Action.Experimenter

  def new(options \\ []) do
    dst_field = options[:dst_field] || raise "dst_field must be specified"
    value = options[:value] || raise "value must be specified"
    default_n_bits = Openflow.Match.Field.n_bits_of(dst_field)

    %NxRegLoad{
      n_bits: options[:n_bits] || default_n_bits,
      offset: options[:offset] || 0,
      dst_field: dst_field,
      value: value
    }
  end

  def to_binary(%NxRegLoad{} = load) do
    ofs_nbits = load.offset <<< 6 ||| load.n_bits - 1
    dst_field_bin = Openflow.Match.codec_header(load.dst_field)

    value_int =
      load.value
      |> Openflow.Match.Field.codec(load.dst_field)
      |> :binary.decode_unsigned(:big)

    Experimenter.pack_exp_header(<<
      @experimenter::32,
      @nxast::16,
      ofs_nbits::16,
      dst_field_bin::4-bytes,
      value_int::size(8)-unit(8)
    >>)
  end

  def read(<<@experimenter::32, @nxast::16, body::bytes>>) do
    <<ofs::10, n_bits::6, dst_field_bin::4-bytes, value_bin::bytes>> = body
    dst_field = Openflow.Match.codec_header(dst_field_bin)
    value = Openflow.Match.Field.codec(value_bin, dst_field)
    %NxRegLoad{n_bits: n_bits + 1, offset: ofs, dst_field: dst_field, value: value}
  end
end
