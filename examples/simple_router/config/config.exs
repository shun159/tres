# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
use Mix.Config

config :tres,
  protocol: :tcp,
  port: 6653,
  max_connections: 10,
  num_acceptors: 10,
  callback_module: SimpleRouter.Openflow.Controller,
  callback_args: []

config :simple_router,
  interfaces: %{
    "veth1" => %{mac_address: "02:00:00:01:00:01", ip_address: "192.168.1.1/24"},
    "veth3" => %{mac_address: "02:00:00:01:00:02", ip_address: "192.168.2.1/24"},
  },
  routes: %{
    "0.0.0.0/0" => "192.168.1.2"
  }
