#!/bin/bash

URL="http://127.0.0.1/api/health"
LOG="/var/log/watchdog.log"
FAIL=0

while true; do
  if curl -sf --max-time 5 "$URL" > /dev/null; then
    FAIL=0
  else
    FAIL=$((FAIL+1))
    echo "$(date '+%F %T') health check failed ($FAIL)" >> "$LOG"
    if [ "$FAIL" -ge 3 ]; then
      echo "$(date '+%F %T') CONSECUTIVE_FAILURE" >> "$LOG"
      FAIL=0
    fi
  fi
  sleep 5
done