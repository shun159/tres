# Tres - a Elixir OpenFlow development platform

## Overview

Tres is a framework and set of helper libraries to develop OpenFlow controllers in Elixir.

## Installation

```elixir
def deps do
  [
    {:tres, github: "shun159/tres", branch: "develop"}
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
