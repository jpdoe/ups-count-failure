#!/bin/bash
# Quick script, count UPS power failures extracted with ups_extract.sh
# Author: Jan Polák
shopt -s globstar
set -euo pipefail

dir="$1"


find "$dir" -type f -name 'ups-*.txt' |while read -r fname; do
    # number of failures
    num=$(grep -c "power failed" "$fname")
    # ups name
    name=$(basename -s ".txt" "$fname")
    # write to tmp file
    printf "%d power failures on %s\n" "$num" "$name" >> counts.txt
    

done
# head
printf "Number of UPS power failures\n" > counts_sorted.txt
printf "*****************************\n\n" >> counts_sorted.txt

sort -nr counts.txt >> counts_sorted.txt
# delete tmp file
rm counts.txt
