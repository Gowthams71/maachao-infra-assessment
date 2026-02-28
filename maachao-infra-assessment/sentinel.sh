#!/bin/bash

LOG="/var/log/nginx/access.log"
OUT="/var/log/sentinel.log"
THRESHOLD=5

is_whitelisted() {
  case "$1" in
    127.0.0.1|::1) return 0 ;;
    *) return 1 ;;
  esac
}

grep ' 429 ' "$LOG" | awk '{print $1}' | sort | uniq -c | while read count ip; do
  if (( count > THRESHOLD )); then
    if is_whitelisted "$ip"; then continue; fi
    if sudo ufw status | grep -qw "$ip"; then continue; fi

    sudo ufw deny from "$ip"
    echo "$(date '+%F %T') BLOCKED: $ip after $count violations" >> "$OUT"
  fi
done