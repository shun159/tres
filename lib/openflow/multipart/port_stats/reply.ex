defmodule Openflow.Multipart.PortStats.Reply do
  defstruct(
    version:      4,
    xid:          0,
    datapath_id:  nil, # virtual field
    flags:        [],
    ports:        []
  )

  alias __MODULE__

  def ofp_type, do: 18

  def new(ports \\ []) do
    %Reply{ports: ports}
  end

  def read(<<ports_bin::bytes>>) do
    ports = Openflow.Multipart.PortStats.read(ports_bin)
    %Reply{ports: ports}
  end
end

defmodule Openflow.Multipart.PortStats do
  defstruct(
    port_number:   0,
    rx_packets:    0,
    tx_packets:    0,
    rx_bytes:      0,
    tx_bytes:      0,
    rx_dropped:    0,
    tx_dropped:    0,
    rx_errors:     0,
    tx_errors:     0,
    rx_frame_err:  0,
    rx_over_err:   0,
    rx_crc_err:    0,
    collisions:    0,
    duration_sec:  0,
    duration_nsec: 0
  )

  alias __MODULE__

  def read(binary) do
    do_read([], binary)
  end

  # private functions

  defp do_read(acc, ""), do: Enum.reverse(acc)
  defp do_read(acc, <<port_stats_bin::112-bytes, rest::bytes>>) do
    do_read([codec(port_stats_bin)|acc], rest)
  end

  defp codec(<<port_no::32, _::size(4)-unit(8), rx_packets::64,
               tx_packets::64, rx_bytes::64, tx_bytes::64,
               rx_dropped::64, tx_dropped::64, rx_errors::64,
               tx_errors::64, rx_frame_err::64, rx_over_err::64,
               rx_crc_err::64, collisions::64,
               duration_sec::32, duration_nsec::32>>) do
    %PortStats{port_number:   port_no,
               rx_packets:    rx_packets,
               tx_packets:    tx_packets,
               rx_bytes:      rx_bytes,
               tx_bytes:      tx_bytes,
               rx_dropped:    rx_dropped,
               tx_dropped:    tx_dropped,
               rx_errors:     rx_errors,
               tx_errors:     tx_errors,
               rx_frame_err:  rx_frame_err,
               rx_over_err:   rx_over_err,
               rx_crc_err:    rx_crc_err,
               collisions:    collisions,
               duration_sec:  duration_sec,
               duration_nsec: duration_nsec}
  end
end
