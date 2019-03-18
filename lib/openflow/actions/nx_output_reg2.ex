defmodule Openflow.Action.NxOutputReg2 do
  import Bitwise

  defstruct(
    n_bits: 0,
    offset: 0,
    src_field: nil,
    max_len: :no_buffer
  )

  @experimenter 0x00002320
  @nxast 32

  alias __MODULE__
  alias Openflow.Action.Experimenter

  def new(options \\ []) do
    src_field = options[:src_field] || raise "src_field must be specified"
    default_n_bits = Openflow.Match.Field.n_bits_of(src_field)

    %NxOutputReg2{
      n_bits: options[:n_bits] || default_n_bits,
      offset: options[:offset] || 0,
      src_field: src_field,
      max_len: options[:max_len] || :no_buffer
    }
  end

  def to_binary(%NxOutputReg2{} = output_reg) do
    src_field_bin = Openflow.Match.codec_header(output_reg.src_field)
    ofs_nbits = output_reg.offset <<< 6 ||| output_reg.n_bits - 1
    max_len = Openflow.Utils.get_enum(output_reg.max_len, :controller_max_len)

    padding =
      src_field_bin
      |> byte_size()
      |> Openflow.Utils.padding(10)

    Experimenter.pack_exp_header(<<
      @experimenter::32,
      @nxast::16,
      ofs_nbits::16,
      max_len::16,
      src_field_bin::bytes,
      0::size(padding)-unit(8)
    >>)
  end

  def read(<<@experimenter::32, @nxast::16, body::bytes>>) do
    <<ofs::10, n_bits::6, max_len::16, oxm_header::4-bytes, rest::bitstring>> = body
    exp_size = match_header_size(oxm_header) - 4
    <<experimenter_int::size(exp_size)-unit(8), _padding::bytes>> = rest

    src_field =
      Openflow.Match.codec_header(<<oxm_header::bytes, experimenter_int::size(exp_size)-unit(8)>>)

    max_len = Openflow.Utils.get_enum(max_len, :controller_max_len)
    %NxOutputReg2{n_bits: n_bits + 1, offset: ofs, src_field: src_field, max_len: max_len}
  end

  # private functions

  defp match_header_size(<<0xFFFF::16, _::bytes>>), do: 8
  defp match_header_size(<<_::16, _::bytes>>), do: 4
end
