defmodule Openflow.Action.NxCheckPktLarger do
  defstruct(
    pkt_len: 0,
    offset: 0,
    dst_field: nil
  )

  @experimenter 0x00002320
  @nxast 49

  alias __MODULE__
  alias Openflow.Action.Experimenter

  @type t :: %NxCheckPktLarger{dst_field: atom(), pkt_len: 0..0xFFFF, offset: 0..0xFFFF}

  @spec new(dst_field: atom(), pkt_len: 0..0xFFFF, offset: 0..0xFFFF) :: t()
  def new(options \\ []) do
    dst_field = options[:dst_field] || raise "dst_field must be specified"
    pkt_len = options[:pkt_len] || raise "pkt_len must be specified"
    ofs = Keyword.get(options, :offset, 0)
    %NxCheckPktLarger{dst_field: dst_field, pkt_len: pkt_len, offset: ofs}
  end

  @spec to_binary(t()) :: binary()
  def to_binary(%NxCheckPktLarger{} = pkt_larger) do
    dst_field_bin = Openflow.Match.codec_header(pkt_larger.dst_field)
    pkt_len = pkt_larger.pkt_len
    ofs = pkt_larger.offset

    Experimenter.pack_exp_header(<<
      @experimenter::32,
      @nxast::16,
      pkt_len::16,
      ofs::16,
      dst_field_bin::4-bytes,
      0::size(10)-unit(8)
    >>)
  end

  @spec read(binary()) :: t()
  def read(<<@experimenter::32, @nxast::16, body::bytes>>) do
    <<pkt_len::16, ofs::16, dst_field_bin::4-bytes, _::bytes>> = body
    dst_field = Openflow.Match.codec_header(dst_field_bin)
    %NxCheckPktLarger{dst_field: dst_field, pkt_len: pkt_len, offset: ofs}
  end
end
