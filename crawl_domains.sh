#!/usr/bin/env bash

# Check if the required programs are installed
if ! command -v curl > /dev/null || ! command -v grep > /dev/null; then
  printf "Error: curl and grep must be installed.\n" >&2
  exit 1
fi

# Get the parameter
param=$1

# Check if a parameter was provided
if [ -z "$param" ]; then
  printf "Error: missing parameter.\n" >&2
  exit 1
fi

# Crawl the domains and subdomains
result=$(curl -s -L https://crt.sh/?q=%25.$param | grep "$param" | awk '{print $NF}')

# Save the results to a file
echo "$result" > "$param.txt"

printf "Saved %d domains and subdomains to %s.txt\n" "$(wc -l < "$param.txt")" "$param"
