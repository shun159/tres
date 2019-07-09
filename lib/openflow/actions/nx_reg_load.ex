defmodule Openflow.Action.NxRegLoad do
  @moduledoc """
  Copies value[0:n_bits] to dst[ofs:ofs+n_bits], where a[b:c] denotes the bits
  within 'a' numbered 'b' through 'c' (not including bit 'c').  Bit numbering
  starts at 0 for the least-significant bit, 1 for the next most significant
  bit, and so on.

  'dst' is an nxm_header with nxm_hasmask=0.  See the documentation for
  NXAST_REG_MOVE, above, for the permitted fields and for the side effects of
  loading them.

  The 'ofs' and 'n_bits' fields are combined into a single 'ofs_nbits' field
  to avoid enlarging the structure by another 8 bytes.  To allow 'n_bits' to
  take a value between 1 and 64 (inclusive) while taking up only 6 bits, it is
  also stored as one less than its true value:

  ```
  15                           6 5                0
  +------------------------------+------------------+
  |              ofs             |    n_bits - 1    |
  +------------------------------+------------------+
  ```

  The switch will reject actions for which ofs+n_bits is greater than the
  width of 'dst', or in which any bits in 'value' with value 2n_bits or
  greater are set to 1, with error type OFPET_BAD_ACTION, code
  OFPBAC_BAD_ARGUMENT.
  """

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
    default_n_bits = Openflow.Match.n_bits_of(dst_field)

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
      |> Openflow.Match.encode_value(load.dst_field)
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
    value = Openflow.Match.decode_value(value_bin, dst_field)
    %NxRegLoad{n_bits: n_bits + 1, offset: ofs, dst_field: dst_field, value: value}
  end
end
