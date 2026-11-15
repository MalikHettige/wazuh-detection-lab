#!/bin/bash
# Pin the host-only address of this VM so it never changes (agents and the Wazuh dashboard rely on it).
# Run as: sudo bash set-static-ip.sh ADDRESS     (an unused address in your host-only range, ending in a free number)
# Run it BEFORE installing Wazuh.
set -e
ADDR="$1"
if [ -z "$ADDR" ]; then
  echo "Usage: sudo bash set-static-ip.sh ADDRESS"
  exit 1
fi
IF=$(ls /sys/class/net | grep -v -e '^lo$' -e '^enp0s3$' | head -n1)
if [ -z "$IF" ]; then
  echo "No host-only interface found."
  exit 1
fi
cat > /etc/netplan/60-hostonly.yaml <<EOF
network:
  version: 2
  ethernets:
    $IF:
      dhcp4: false
      addresses:
        - $ADDR/24
EOF
chmod 600 /etc/netplan/60-hostonly.yaml
netplan apply
sleep 3
ip -br a
