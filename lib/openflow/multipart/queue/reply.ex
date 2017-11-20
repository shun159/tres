defmodule Openflow.Multipart.Queue.Reply do
  defstruct(
    version:      4,
    xid:          0,
    datapath_id:  nil, # virtual field
    aux_id:       nil,
    flags:        [],
    queues:       []
  )

  alias __MODULE__

  def ofp_type, do: 18

  def new(queues \\ []) do
    %Reply{queues: queues}
  end

  def read(<<queues_bin::bytes>>) do
    queues = Openflow.Multipart.Queue.read(queues_bin)
    %Reply{queues: queues}
  end

  def append_body(%Reply{queues: queues} = message, %Reply{flags: [:more], queues: continue}) do
    %{message|queues: [continue|queues]}
  end
  def append_body(%Reply{queues: queues} = message, %Reply{flags: [], queues: continue}) do
    new_queues = [continue|queues]
    |> Enum.reverse
    |> List.flatten
    %{message|queues: new_queues}
  end
end

defmodule Openflow.Multipart.Queue do
  defstruct(
    port_number:   0,
    queue_id:      0,
    tx_bytes:      0,
    tx_packets:    0,
    tx_errors:     0,
    duration_sec:  0,
    duration_nsec: 0
  )

  alias __MODULE__

  def read(binary) do
    do_read([], binary)
  end

  # private functions

  defp do_read(acc, ""), do: Enum.reverse(acc)
  defp do_read(acc, <<queue_bin::40-bytes, rest::bytes>>) do
    do_read([codec(queue_bin)|acc], rest)
  end

  defp codec(<<port_no::32, queue_id::32, tx_bytes::64,
               tx_packets::64, tx_errors::64,
               duration_sec::32, duration_nsec::32>>) do
    %Queue{port_number:   port_no,
           queue_id:      queue_id,
           tx_bytes:      tx_bytes,
           tx_packets:    tx_packets,
           tx_errors:     tx_errors,
           duration_sec:  duration_sec,
           duration_nsec: duration_nsec}
  end
end
