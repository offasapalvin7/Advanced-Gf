#!/usr/bin/env bash

# Check if curl is installed
if ! command -v curl > /dev/null; then
  printf "Error: curl is not installed.\n" >&2
  exit 1
fi

# Parse command line arguments
while [[ $# -gt 0 ]]; do
  arg="$1"
  case $arg in
    -d|--directory)
      shift
      output_dir="$1"
      ;;
    *)
      printf "Error: Invalid argument %s\n" "$arg" >&2
      exit 1
      ;;
  esac
  shift
done

# Set default output directory if not specified
if [ -z "$output_dir" ]; then
  output_dir="."
fi

# Read URL or subdomain from file
while read -r line; do
  # Send HTTP request to URL
  status=$(curl -s -o /dev/null -w "%{http_code}" "$line")

  # Write status code to file
  printf "%s\n" "$status" > "$output_dir/$line.txt"
done < url-list.txt
