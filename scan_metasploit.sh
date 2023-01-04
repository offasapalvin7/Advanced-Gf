#!/usr/bin/env bash

# Check if Metasploit is installed
if ! command -v msfconsole > /dev/null; then
  echo "Metasploit is not installed. Exiting."
  exit 1
fi

# Scan for available scans
scans=$(msfconsole --quiet -x "search type:auxiliary" | grep "Name:" | awk '{print $2}')

echo "Available scans:"
echo "$scans"
