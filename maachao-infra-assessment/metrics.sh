#!/bin/bash

CPU=$(awk '{print $1}' /proc/loadavg)
RAM=$(free -m | awk '/^Mem:/ {print $7}')
DISK=$(df / | awk 'NR==2 {gsub(/%/, "", $5); print $5}')
UFW=$(sudo ufw status | grep -c DENY)

cat <<EOF
{
  "cpu_load_1m": $CPU,
  "ram_available_mb": $RAM,
  "disk_used_pct": $DISK,
  "active_ufw_deny_rules": $UFW
}
EOF