#!/bin/bash
# Configure the host-only adapter on the wazuh VM (finds the second interface automatically)
set -e
IF=$(ls /sys/class/net | grep -v -e '^lo$' -e '^enp0s3$' | head -n1)
if [ -z "$IF" ]; then
  echo "No second network interface found. Check VirtualBox Adapter 2 is enabled (Host-only) and reboot the VM."
  exit 1
fi
echo "Configuring interface: $IF"
cat > /etc/netplan/60-hostonly.yaml <<EOF
network:
  version: 2
  ethernets:
    $IF:
      dhcp4: true
EOF
chmod 600 /etc/netplan/60-hostonly.yaml
netplan apply
sleep 3
ip -br a
