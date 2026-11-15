#!/bin/bash
# Wazuh 4.14 all-in-one install for the lab (run as your normal user, not with sudo)
# Needs internet on the NAT adapter, about 1-1.5 GB of data, and takes 10-20 minutes.
# Take the base-os snapshot BEFORE running this. If it fails, restore the snapshot and run again.
set -e
cd ~
echo "Free memory and disk before install:"
free -h | head -2
df -h / | tail -1
curl -sO https://packages.wazuh.com/4.14/wazuh-install.sh
sudo bash ./wazuh-install.sh -a 2>&1 | tee ~/wazuh-install.log
echo
echo "Done. The admin password was printed above. Store it in Bitwarden. Do not paste it into chat, screenshots or the repo."
