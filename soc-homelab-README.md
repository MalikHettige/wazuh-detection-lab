# soc-homelab

A small, free SOC and purple-team home lab built to show I can detect, investigate and explain attacks, and that I understand them from the bug bounty side.

Status: in progress (started Nov 2026).

## Architecture
| VM | Role |
|----|------|
| wazuh | Wazuh 4.14 all-in-one (manager, indexer, dashboard) on Ubuntu Server 24.04 |
| linux-victim | Ubuntu Server 24.04 with Wazuh agent, nginx and OWASP Juice Shop (Docker) |
| win-victim | Windows Server evaluation with Wazuh agent and Sysmon (started only when needed) |

Network: VirtualBox host-only. Nothing is attacked outside the lab. Snapshots are taken before every test.

## Layout
- `reports/` investigation reports, one per alert (see `reports/TEMPLATE.md`)
- `detections/` custom Wazuh rules with test evidence and false-positive notes
- `notes/` setup notes and what normal looks like
- `media/` screenshots and the walkthrough video link

## Progress
- [ ] Wazuh running, one agent connected
- [ ] Windows agent + Sysmon
- [ ] 3+ investigation reports published
- [ ] Web-attack detection rules for Juice Shop
- [ ] Walkthrough video and coverage table

## Rules for this repo
No secrets: no passwords, keys, tokens, IP addresses, MAC addresses or serial numbers are committed.
