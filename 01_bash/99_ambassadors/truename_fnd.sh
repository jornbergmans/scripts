#!/bin/bash

IFS=$'\n'

for i in $(find "$1" -type f); do
    # sed 's|-ref.mp4|.mov|g' > truename
    truename=$(basename "$i");
    sedname=$(echo "$truename" | sed 's|-ref.mp4|.mov|');

    # for original in $(
    find "$2" -iname "$sedname" -delete
    # ); do
    #   echo $original
    # done

done

  find $2 -type d -empty -delete
