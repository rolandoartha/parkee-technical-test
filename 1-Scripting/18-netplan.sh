#!/bin/bash

NETPLAN_FILE="/etc/netplan/01-netcfg.yaml"

echo "network:
  version: 2
  ethernets:
    eth0:
      dhcp4: no
      addresses: [192.168.1.100/24]
      gateway4: 192.168.1.1
      nameservers:
        addresses: [8.8.8.8, 8.8.4.4]" | sudo tee "$NETPLAN_FILE"

sudo netplan apply
