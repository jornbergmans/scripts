#!/bin/bash
IFS=$'\n'

for d in $(find $1 -type d); do
  # find $1 -type f -iname "$d*" -exec echo {} \;
based=$(basename $d) | head
# head $based
    # echo $f
    # mv $f $d
  done
