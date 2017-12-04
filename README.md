# Tres - a Elixir OpenFlow development platform

## Overview

Tres is a framework and set of helper libraries to develop OpenFlow controllers in Elixir.

the purpose of this project is to design and prototype an experimental network switch controller that implements the OpenFlow 1.3.x. The project explores the scalability and robustness of such controllers on a scale much larger than typically considered: 100,000s of endpoints, 10,000s of switches.

## Installation

```elixir
def deps do
  [
    {:tres, git: "https://gh.iiji.jp/Isono/tres", branch: "develop"}
  ]
end
```

## callbacks
 
```elixir
config :tres,
  callback_module: Tres.ExampleHandler,
  callback_args:   []
```

To use `Tres.Controller` with your code, set the handler callback_module to your callback module.
This module must implement the `Module.start_link/2` that returns `on_start`.

Set the callback_args to the terms you want pass to the `start_link/2` callback function.
