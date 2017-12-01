# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
use Mix.Config

config :heckle,
  vlan_tagging:  true,
  vlan_id:       123,
  vlan_trunk:    "veth0",
  access_port1:  "veth4",
  access_port2:  "veth3",
  receiver_mac:  "00000000000f",
  receiver_ip:   {8,8,8,8},
  sender_mac:    "001122334455",
  inside_local:  {192,168,5,10},
  outside_local: {192,168,255,1},
  flow_pattern:  :bum

config :tres,
  protocol:        :tcp,
  port:            6653,
  max_connections: 10,
  num_acceptors:   10,
  callback_module: Heckle.Controller,
  callback_args:   ["0000d2851d52d749"]

config :logger,
  level: :debug,
  format: "$date $time [$level] $metadata$message\n",
  metadata: [:application],
  handle_otp_reports: true
