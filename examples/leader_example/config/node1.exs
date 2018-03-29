use Mix.Config

config :tres,
  protocol:        :tcp,
  port:            6653,
  max_connections: 10,
  num_acceptors:   10,
  callback_module: LeaderExample.Leader,
  callback_args:   []
