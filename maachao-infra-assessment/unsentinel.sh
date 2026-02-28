#!/bin/bash

IP="$1"
LOG_FILE="/var/log/sentinel.log"


if [[ -z "$IP" ]]; then
  echo "Usage: $0 <IP_ADDRESS>"
  exit 1
fi

RULE_NUM=$(sudo ufw status numbered | grep "$IP" | awk -F'[][]' '{print $2}')

if [[ -z "$RULE_NUM" ]]; then
  echo "IP $IP not currently blocked"
  exit 1
fi

sudo ufw delete "$RULE_NUM"


echo "$(date '+%Y-%m-%d %H:%M:%S') UNBLOCKED: $IP" >> "$LOG_FILE"

exit 0

