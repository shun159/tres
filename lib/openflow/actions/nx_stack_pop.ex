defmodule Openflow.Action.NxStackPop do
  defstruct(
    n_bits: 0,
    offset: 0,
    field: nil
  )

  @experimenter 0x00002320
  @nxast 28

  alias __MODULE__
  alias Openflow.Action.Experimenter

  def new(options) do
    field = options[:field] || raise "field must be specified"
    default_n_bits = Openflow.Match.Field.n_bits_of(field)

    %NxStackPop{
      n_bits: options[:n_bits] || default_n_bits,
      offset: options[:offset] || 0,
      field: field
    }
  end

  def to_binary(%NxStackPop{} = stack_pop) do
    field_bin = Openflow.Match.codec_header(stack_pop.field)

    Experimenter.pack_exp_header(<<
      @experimenter::32,
      @nxast::16,
      stack_pop.offset::16,
      field_bin::4-bytes,
      stack_pop.n_bits::16,
      0::size(6)-unit(8)
    >>)
  end

  def read(
        <<@experimenter::32, @nxast::16, ofs::16, field_bin::4-bytes, n_bits::16,
          _::size(6)-unit(8)>>
      ) do
    field = Openflow.Match.codec_header(field_bin)
    %NxStackPop{n_bits: n_bits, offset: ofs, field: field}
  end
end
