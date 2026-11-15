#!/bin/bash
# Run ONCE on a freshly cloned VM, as: sudo bash fix-clone.sh NEW-HOSTNAME
# Gives the clone its own hostname, machine-id (so it gets its own IP address) and SSH host keys.
# Your SSH session will drop at the end. Log in again.
set -e
NEW="$1"
if [ -z "$NEW" ]; then
  echo "Usage: sudo bash fix-clone.sh NEW-HOSTNAME"
  exit 1
fi
hostnamectl set-hostname "$NEW"
if grep -q "^127.0.1.1" /etc/hosts; then
  sed -i "s/^127.0.1.1.*/127.0.1.1 $NEW/" /etc/hosts
else
  echo "127.0.1.1 $NEW" >> /etc/hosts
fi
rm -f /etc/machine-id /var/lib/dbus/machine-id
systemd-machine-id-setup
ln -sf /etc/machine-id /var/lib/dbus/machine-id
rm -f /etc/ssh/ssh_host_*
dpkg-reconfigure -f noninteractive openssh-server
netplan apply
sleep 3
ip -br a
echo "Done. Rebooting in 5 seconds so everything picks up the new identity."
sleep 5
reboot
