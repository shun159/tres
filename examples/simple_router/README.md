# SimpleRouter

#### An OpenFlow controller that emulates layer 3 switch (router).

## Configuration

```elixir
config :simple_router,
  interfaces: %{
    "veth1" => %{mac_address: "02:00:00:01:00:01", ip_address: "192.168.1.1/24"},
    "veth3" => %{mac_address: "02:00:00:01:00:02", ip_address: "192.168.2.1/24"},
  },
  routes: %{
    "0.0.0.0/0" => "192.168.1.2"
  }
```

## Flow Tables

```
> $ sudo ovs-ofctl dump-flows br0 -OOpenFlow13 --color=auto                                                                                                                                                                                  
 cookie=0x0, duration=10.217s, table=0, n_packets=3, n_bytes=126, priority=1,arp actions=goto_table:1
 cookie=0x0, duration=10.217s, table=0, n_packets=19, n_bytes=1862, priority=1,ip actions=goto_table:2
 cookie=0x0, duration=10.208s, table=1, n_packets=1, n_bytes=42, priority=0,arp,in_port=veth1,arp_tpa=192.168.1.1,arp_op=1 actions=learn(table=4,idle_timeout=300,priority=1,NXM_NX_REG0[]=NXM_OF_ARP_SPA[],load:NXM_OF_ETH_SRC[]->NXM_OF_ETH_DST[]),push:NXM_OF_ARP_TPA[],push:NXM_NX_ARP_SHA[],push:NXM_OF_ARP_SPA[],push:NXM_OF_ETH_SRC[],pop:NXM_OF_ETH_DST[],pop:NXM_OF_ARP_TPA[],pop:NXM_NX_ARP_THA[],pop:NXM_OF_ARP_SPA[],set_field:2->arp_op,set_field:02:00:00:01:00:01->arp_sha,set_field:02:00:00:01:00:01->eth_src,IN_PORT
 cookie=0x0, duration=10.207s, table=1, n_packets=1, n_bytes=42, priority=0,arp,in_port=veth1,arp_tpa=192.168.1.1,arp_op=2 actions=learn(table=4,idle_timeout=300,priority=1,NXM_NX_REG0[]=NXM_OF_ARP_SPA[],load:NXM_OF_ETH_SRC[]->NXM_OF_ETH_DST[])
 cookie=0x0, duration=10.206s, table=1, n_packets=1, n_bytes=42, priority=0,arp,in_port=veth3,arp_tpa=192.168.2.1,arp_op=1 actions=learn(table=4,idle_timeout=300,priority=1,NXM_NX_REG0[]=NXM_OF_ARP_SPA[],load:NXM_OF_ETH_SRC[]->NXM_OF_ETH_DST[]),push:NXM_OF_ARP_TPA[],push:NXM_NX_ARP_SHA[],push:NXM_OF_ARP_SPA[],push:NXM_OF_ETH_SRC[],pop:NXM_OF_ETH_DST[],pop:NXM_OF_ARP_TPA[],pop:NXM_NX_ARP_THA[],pop:NXM_OF_ARP_SPA[],set_field:2->arp_op,set_field:02:00:00:01:00:02->arp_sha,set_field:02:00:00:01:00:02->eth_src,IN_PORT
 cookie=0x0, duration=10.206s, table=1, n_packets=0, n_bytes=0, priority=0,arp,in_port=veth3,arp_tpa=192.168.2.1,arp_op=2 actions=learn(table=4,idle_timeout=300,priority=1,NXM_NX_REG0[]=NXM_OF_ARP_SPA[],load:NXM_OF_ETH_SRC[]->NXM_OF_ETH_DST[])
 cookie=0x0, duration=10.205s, table=2, n_packets=0, n_bytes=0, priority=124,ip,nw_dst=192.168.1.0/24 actions=move:NXM_OF_IP_DST[]->NXM_NX_REG0[],goto_table:3
 cookie=0x0, duration=10.205s, table=2, n_packets=9, n_bytes=882, priority=124,ip,nw_dst=192.168.2.0/24 actions=move:NXM_OF_IP_DST[]->NXM_NX_REG0[],goto_table:3
 cookie=0x0, duration=10.205s, table=2, n_packets=10, n_bytes=980, priority=0,ip actions=set_field:0xc0a80102->reg0,goto_table:3
 cookie=0x0, duration=10.212s, table=3, n_packets=10, n_bytes=980, priority=24,reg0=0xc0a80100/0xffffff00 actions=set_field:0x1->reg1,resubmit(,4),resubmit(,5)
 cookie=0x0, duration=10.212s, table=3, n_packets=9, n_bytes=882, priority=24,reg0=0xc0a80200/0xffffff00 actions=set_field:0x2->reg1,resubmit(,4),resubmit(,5)
 cookie=0x0, duration=9.891s, table=4, n_packets=9, n_bytes=882, idle_timeout=300, priority=1,reg0=0xc0a80202 actions=load:0x9a9114dd25d8->NXM_OF_ETH_DST[]
 cookie=0x0, duration=9.855s, table=4, n_packets=9, n_bytes=882, idle_timeout=300, priority=1,reg0=0xc0a80102 actions=load:0x7a69d574651c->NXM_OF_ETH_DST[]
 cookie=0x0, duration=10.207s, table=4, n_packets=1, n_bytes=98, priority=0,reg1=0x1 actions=controller(userdata=41.52.50.5f.6d.69.73.73.69.6e.67.ff.ff.ff.ff.ff.ff.02.00.00.01.00.01.08.06.00.01.08.00.06.04.00.01.02.00.00.01.00.01.c0.a8.01.01.00.00.00.00.00.00,pause)
 cookie=0x0, duration=10.206s, table=4, n_packets=0, n_bytes=0, priority=0,reg1=0x2 actions=controller(userdata=41.52.50.5f.6d.69.73.73.69.6e.67.ff.ff.ff.ff.ff.ff.02.00.00.01.00.02.08.06.00.01.08.00.06.04.00.01.02.00.00.01.00.02.c0.a8.02.01.00.00.00.00.00.00,pause)
 cookie=0x0, duration=10.206s, table=5, n_packets=9, n_bytes=882, priority=1,reg1=0x1 actions=group:1
 cookie=0x0, duration=10.205s, table=5, n_packets=9, n_bytes=882, priority=1,reg1=0x2 actions=group:2
 ```
 
## Group Tables
 ```
> $ sudo ovs-ofctl dump-groups br0 -OOpenFlow13 --color=auto                                                                                                                                                                                 
OFPST_GROUP_DESC reply (OF1.3) (xid=0x2):
 group_id=1,type=indirect,bucket=actions=set_field:02:00:00:01:00:01->eth_src,output:veth1
 group_id=2,type=indirect,bucket=actions=set_field:02:00:00:01:00:02->eth_src,output:veth3
```
