defmodule Openflow.Action.NxOutputReg do
  import Bitwise

  defstruct(
    n_bits: 0,
    offset: 0,
    src_field: nil,
    max_len: :no_buffer
  )

  @experimenter 0x00002320
  @nxast 15

  alias __MODULE__
  alias Openflow.Action.Experimenter

  @type max_len :: :no_buffer | :max | non_neg_integer()
  @type t :: %NxOutputReg{
          n_bits: pos_integer(),
          offset: non_neg_integer(),
          src_field: atom(),
          max_len: max_len()
        }

  @spec new(
          n_bits: pos_integer(),
          offset: non_neg_integer(),
          src_field: atom(),
          max_len: max_len()
        ) :: t()
  def new(options) do
    src_field = options[:src_field] || raise "src_field must be specified"
    default_n_bits = Openflow.Match.n_bits_of(src_field)

    %NxOutputReg{
      n_bits: options[:n_bits] || default_n_bits,
      offset: options[:offset] || 0,
      src_field: src_field,
      max_len: options[:max_len] || :no_buffer
    }
  end

  def to_binary(%NxOutputReg{} = output_reg) do
    src_field_bin = Openflow.Match.codec_header(output_reg.src_field)
    ofs_nbits = output_reg.offset <<< 6 ||| output_reg.n_bits - 1
    max_len = Openflow.Utils.get_enum(output_reg.max_len, :controller_max_len)

    Experimenter.pack_exp_header(<<
      @experimenter::32,
      @nxast::16,
      ofs_nbits::16,
      src_field_bin::4-bytes,
      max_len::16,
      0::size(6)-unit(8)
    >>)
  end

  def read(<<@experimenter::32, @nxast::16, body::bytes>>) do
    <<ofs::10, n_bits::6, src_field_bin::4-bytes, max_len::16, _::size(6)-unit(8)>> = body
    src_field = Openflow.Match.codec_header(src_field_bin)
    max_len = Openflow.Utils.get_enum(max_len, :controller_max_len)
    %NxOutputReg{n_bits: n_bits + 1, offset: ofs, src_field: src_field, max_len: max_len}
  end
end
