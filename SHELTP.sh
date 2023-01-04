#!/usr/bin/env bash

# Check if curl is installed
if ! command -v curl > /dev/null; then
  printf "Error: curl is not installed.\n" >&2
  exit 1
fi

# Read URL or subdomain from file
while read -r line; do
  # Send HTTP request to URL
  status=$(curl -s -o /dev/null -w "%{http_code}" "$line")

  # Print status code
  printf "%s %s\n" "$line" "$status"
done < url-list.txt
