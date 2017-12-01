# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
use Mix.Config

config :heckle,
  vlan_tagging:  true,
  vlan_id:       123,
  vlan_trunk1:   "1",
  vlan_trunk2:   "4",
  access_port1:  "2",
  access_port2:  "3",
  receiver_mac:  "1a2c3d0e0191",
  receiver_ip:   {192,168,123,1},
  sender_mac:    "cec9bd531dfc",
  inside_local:  {192,168,11,1},
  outside_local: {192,168,123,2},
  flow_pattern:  :nat # :nat || :bum

config :tres,
  protocol:        :tcp,
  port:            6633,
  max_connections: 10,
  num_acceptors:   10,
  callback_module: Heckle.Controller,
  callback_args:   ["0002b05ada98d790"]

config :logger,
  level: :info,
  format: "$date $time [$level] $metadata$message\n",
  metadata: [:application],
  handle_otp_reports: true
