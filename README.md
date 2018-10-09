# Tres - an Elixir OpenFlow development platform

## Overview

Tres is a framework and set of helper libraries to develop OpenFlow controllers in Elixir.

## How to build your own controller application

### Installation

```elixir
def deps do
  [
    {:tres, github: "shun159/tres", branch: "develop"}
  ]
end
```

### callbacks
 
```elixir
config :tres,
  callback_module: Tres.ExampleHandler,
  callback_args:   []
```

To use `Tres.Controller` with your code, set the handler callback_module to your callback module.
This module must implement the `Module.start_link/1` that returns `on_start`.

Set the callback_args to the terms you want pass to the `start_link/2` callback function.

```
% cat lib/sample.ex
defmodule Sample do
  use GenServer
  use Tres.Controller

  def start_link([datapath_id, _start_args]) do
    GenServer.start_link(__MODULE__, [datapath_id])
  end
  
  def init([datapath_id]) do
    # As an example create a flow to receive all packet_ins from port 1
    redirect_action = Output.new(:controller)
    apply_ins = ApplyActions.new(redirect_action)
    match = Match.new(in_port: 1)
    :ok = send_flow_mod_add(datapath_id, 
                            priority: 1,
                            match: match,
                            instructions: [apply_ins])
    {:ok, datapath_id}
  end
  
  def handle_info(%PacketIn{} = packet_in, datapath_id) do
    # print the packet_in message struct
    IO.inspect(packet_in)
    {:noreply, datapath_id}
  end
end
```

## To run the controller

```bash
$ iex -S mix
```

## Examples

- learning-switch: Simple Layer2 switch
- leader-example: Simple election based multiple controller using Ulf Wiger's Locks Leader
- patch\_panel: inteligent patch\_panel example
- simple\_router: An OpenFlow controller that emulates layer 3 switch (router).

License
-------
Tres is released under the __SUSHI-WARE LICENSE__.

__私に寿司をおごってください__
