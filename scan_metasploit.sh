#!/usr/bin/env bash

# Check if Metasploit is installed
if ! command -v msfconsole > /dev/null; then
  printf "Metasploit is not installed. Exiting.\n" >&2
  exit 1
fi

# Set default scan type
scan_type=auxiliary

# Process command line arguments
while [ "$#" -gt 0 ]; do
  case "$1" in
    -t|--type)
      scan_type="$2"
      shift 2
      ;;
    -s|--search)
      search_term="$2"
      shift 2
      ;;
    -o|--output)
      output_file="$2"
      shift 2
      ;;
    *)
      printf "Invalid argument: %s\n" "$1" >&2
      exit 1
      ;;
  esac
done

# Build search query
query="search type:$scan_type"
if [ -n "$search_term" ]; then
  query="$query $search_term"
fi

# Search for available scans
scans=$(msfconsole --quiet -x "$query" | grep "Name:" | awk '{print $2}')

if [ -z "$scans" ]; then
  printf "No available scans found.\n"
else
  printf "Available scans:\n"
  printf "%s\n" "$scans" | sort | column -t
fi

# Prompt user to select a scan
printf "Enter the name of the scan you want to use: "
read -r scan_name

# Validate user input
if ! printf "%s\n" "$scans" | grep -qw "$scan_name"; then
  printf "Invalid scan name.\n" >&2
  exit 1
fi

# Save scan to file if specified
if [ -n "$output_file" ]; then
  printf "%s\n" "$scan_name" > "$output_file"
fi

printf "Selected
