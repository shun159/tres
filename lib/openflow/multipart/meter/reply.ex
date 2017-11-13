defmodule Openflow.Multipart.Meter.Reply do
  defstruct(
    version:      4,
    xid:          0,
    datapath_id:  nil, # virtual field
    flags:        [],
    meters:       []
  )

  alias __MODULE__

  def ofp_type, do: 18

  def read(<<meters_bin::bytes>>) do
    meters = Openflow.Multipart.Meter.read(meters_bin)
    %Reply{meters: meters}
  end
end

defmodule Openflow.Multipart.Meter do
  defstruct(
    meter_id:        0,
    flow_count:      0,
    packet_in_count: 0,
    byte_in_count:   0,
    duration_sec:    0,
    duration_nsec:   0,
    band_stats:     []
  )

  @ofp_meter_stats_size 40

  alias __MODULE__

  def read(binary) do
    do_read([], binary)
  end

  # private functions

  defp do_read(acc, ""), do: Enum.reverse(acc)
  defp do_read(acc, <<_::32, length::16, _binary::bytes>> = binary) do
    <<meter_bin::size(length)-bytes, rest::bytes>> = binary
    do_read([codec(meter_bin)|acc], rest)
  end

  defp codec(<<meter_id::32, length::16, _::size(6)-unit(8),
               flow_count::32, packet_in_count::64, byte_in_count::64,
               duration_sec::32, duration_nsec::32, tail::bytes>>) do
    band_stats_size = length - @ofp_meter_stats_size
    <<band_stats_bin::size(band_stats_size)-bytes, _rest::bytes>> = tail
    band_stats = for <<packet_band_count::64, byte_band_count::64 <- band_stats_bin>> do
      %{packet_band_count: packet_band_count,byte_band_count: byte_band_count}
    end
    %Meter{meter_id: meter_id,
           flow_count: flow_count,
           packet_in_count: packet_in_count,
           byte_in_count: byte_in_count,
           duration_sec: duration_sec,
           duration_nsec: duration_nsec,
           band_stats: band_stats}
  end
end
