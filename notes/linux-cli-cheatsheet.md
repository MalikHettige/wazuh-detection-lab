# Linux CLI cheat sheet: Wazuh detection lab (Ubuntu 24.04, Wazuh 4.14)

No passwords, IPs, MACs or keys in this file or in any commit.

## Everyday
```
ls -la                     list files incl. hidden
cd /path ; pwd             move, show where you are
cat file ; less file       read a file (q quits less)
grep -ri "text" /dir       search text recursively
tail -f file               follow a log live (Ctrl+C stops)
sudo nano file             edit (Ctrl+O save, Ctrl+X exit)
df -h ; free -h           disk and RAM
top   (or htop)            what is eating CPU and RAM
ip a                       your VM's network addresses
ss -tulpn                  which ports are listening
```

## Packages and system
```
sudo apt update && sudo apt full-upgrade -y
sudo reboot ; sudo poweroff
journalctl -u SERVICE -f   live service log
```

## Wazuh services (on the wazuh VM)
```
sudo systemctl status wazuh-manager
sudo systemctl status wazuh-indexer
sudo systemctl status wazuh-dashboard
sudo systemctl status filebeat
sudo systemctl restart wazuh-manager      after editing rules
```
Start order if you restart everything: indexer, manager, filebeat, dashboard.

## Wazuh files and tools
```
/var/ossec/logs/ossec.log                 manager log (errors here first)
/var/ossec/logs/alerts/alerts.json        every alert as JSON
/var/ossec/etc/ossec.conf                 main config
/var/ossec/etc/rules/local_rules.xml      your custom rules (IDs 100000+)
/var/ossec/etc/decoders/local_decoder.xml your custom decoders
/etc/wazuh-indexer/jvm.options            indexer memory (-Xms / -Xmx lines)
sudo /var/ossec/bin/wazuh-logtest         paste a log line, see which rule fires
sudo /var/ossec/bin/agent_control -l      list connected agents
```
Dashboard: https://<wazuh-VM-host-only-address> (certificate warning on first visit is expected).
Ports: 1514 and 1515 agents, 55000 API, 9200 indexer, 443 dashboard.

## Agent side (victim VMs)
```
sudo systemctl status wazuh-agent
sudo systemctl restart wazuh-agent
sudo tail -f /var/ossec/logs/ossec.log
/var/ossec/etc/ossec.conf                 manager address and monitored files
```

## Web target (linux-victim)
```
docker ps
docker run -d --restart unless-stopped -p 3000:3000 bkimminich/juice-shop
docker logs -f CONTAINER
sudo tail -f /var/log/nginx/access.log    what Wazuh will ingest
sudo nginx -t && sudo systemctl reload nginx
```

## SSH and files (from Windows Terminal)
```
ssh USER@VM-ADDRESS
scp file USER@VM-ADDRESS:~/          copy to the VM
scp USER@VM-ADDRESS:~/file .         copy from the VM
```

## VirtualBox snapshots (PowerShell on the host)
```
& "C:\Program Files\Oracle\VirtualBox\VBoxManage.exe" snapshot wazuh take base-os
& "C:\Program Files\Oracle\VirtualBox\VBoxManage.exe" snapshot wazuh list
& "C:\Program Files\Oracle\VirtualBox\VBoxManage.exe" snapshot wazuh restore base-os
```
Snapshot before every attack test and after every working milestone.

## Git loop (Git Bash, one command at a time)
```
git pull
git status        read the list before committing
git add .
git commit -m "what changed"
git push
```

## Lab rules
- Attack only the lab VMs, on the host-only network, with a snapshot taken first.
- Never paste the Wazuh install passwords anywhere. Keep them in Bitwarden.
- Run only two lab VMs at once. Quit Docker Desktop and BlueStacks first.
