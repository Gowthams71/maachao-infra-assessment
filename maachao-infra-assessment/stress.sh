#!/bin/bash

URL="http://127.0.0.1/api/status"

while true; do
  curl -s -o /dev/null "$URL"
done

