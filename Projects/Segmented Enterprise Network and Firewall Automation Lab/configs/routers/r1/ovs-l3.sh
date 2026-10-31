#!/bin/bash
set -euo pipefail
BR=br-lan
ovs-vsctl --may-exist add-br $BR -- set bridge $BR other-config:hwaddr='"02:00:00:00:01:00"'
ovs-vsctl --may-exist add-port $BR ens38 -- set port ens38 tag=30
ovs-vsctl --may-exist add-port $BR ens37 -- set port ens37 tag=99
add_svi () {
  local mac; mac=$(cat /sys/class/net/$3/address)
  ovs-vsctl --may-exist add-port $BR $1 -- set port $1 tag=$2 -- set interface $1 type=internal mac="\"$mac\""
  ip addr flush dev $3
  ip link set $3 up
  ip link set $1 up
  ip addr replace $4 dev $1
}
add_svi vlan30 30 ens38 10.10.30.1/24
add_svi vlan99 99 ens37 192.168.8.193/30
