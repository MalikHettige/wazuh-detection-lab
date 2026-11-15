# scripts

Small helper scripts I wrote while building this lab. They exist so VM setup is repeatable and I do not have to retype long commands.

| Script | What it does |
|--------|--------------|
| `setup-hostonly.sh` | Finds the second network adapter on a new Ubuntu VM and enables DHCP on it |
| `set-static-ip.sh` | Pins the host-only address of a VM so agents and the dashboard keep working |
| `fix-clone.sh` | Gives a cloned VM its own hostname, machine-id and SSH host keys |
| `install-wazuh.sh` | Downloads and runs the Wazuh 4.14 all-in-one installer and keeps a log |

Use these only on the lab VMs (Ubuntu Server 24.04), never on the host machine. Read a script before you run it. They use `sudo`, and `install-wazuh.sh` prints the admin password at the end, so store it in a password manager and never commit it.
