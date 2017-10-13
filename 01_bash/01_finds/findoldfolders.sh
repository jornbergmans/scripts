#!/bin/bash

IFS=$'\n'

upfldr=$(find "$1" -type d -maxdepth 1)

for dwnfldr in $upfldr; do
  fldrcnt=$(find "$dwnfldr" -not -newermt 20170101 | wc -l)
  if [ "$fldrcnt" -gt 0 ]; then
  echo "$dwnfldr" >> "$upfldr"/oldfolders.txt
 fi
done
