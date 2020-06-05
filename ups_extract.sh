#!/bin/bash
# Quick script, extract info about ups power failure from email
# Author: Jan Polák
shopt -s globstar
set -euo pipefail

dir="$1"
echo "$1"

find "$dir" -type f -name '*-UPS Event.eml' |while read -r fname; do
    # get raw name
    ups_name_raw=$(grep "Name: " "$fname" | cut -d" " -f2)
    # trim carriage return
    ups_name=$(echo "$ups_name_raw" | tr -d '\r')
    # get event
    ups_event=$(grep -E "[0-9]{2}/[0-9]{2}/" "$fname")
    # write
    echo "$ups_event" >> "$ups_name".txt

done
