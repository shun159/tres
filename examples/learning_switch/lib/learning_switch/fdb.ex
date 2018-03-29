defmodule LearningSwitch.FDB do
  use Agent

  defmodule Entry do
    defstruct [
      mac:       nil,
      port_no:   nil,
      age_max:     0,
      last_update: 0
    ]

    def new(mac, port_no, age_max \\ 180) do
      %Entry{
        mac: mac,
        port_no: port_no,
        age_max: age_max,
        last_update: :os.timestamp
      }
    end

    def update(self, port_no) do
      %{self|port_no: port_no, last_update: :os.timestamp}
    end

    def aged_out?(self) do
      :timer.now_diff(:os.timestamp, self.last_update) > (1000 * self.age_max)
    end
  end

  def start_link do
    Agent.start_link(&Map.new/0)
  end

  def lookup(self, mac) do
    entry = Agent.get(self, &Map.get(&1, mac))
    entry && entry.port_no
  end

  def learn(self, mac, port_no) do
    entry = Agent.get(self, &Map.get(&1, mac))
    entry = if entry do
      Entry.update(entry, port_no)
    else
      Entry.new(mac, port_no)
    end
    Agent.update(self, &Map.put(&1, mac, entry))
  end

  def age(self) do
    mac_addrs = Agent.get(self, &find_aged_entries(&1))
    for mac <- mac_addrs do
      Agent.update(self, &Map.delete(&1, mac))
    end
  end

  # private function

  defp find_aged_entries(map) do
    Enum.flat_map(map, fn({mac, entry}) ->
      case Entry.aged_out?(entry) do
        true  -> [mac]
        false -> []
      end
    end)
  end
end
