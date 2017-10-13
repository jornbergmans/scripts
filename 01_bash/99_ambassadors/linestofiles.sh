#!/bin/bash

for arch in $1/*.txt ; do
  # while read $arch ; do
    # mkdir -p "$1/concat/"
    echo $arch >> "$1/concat.txt"
    # if [ "$arch" != "" ];
    # then
    # echo $arch >> "$1/concat.txt"
    # fi
#  done
 done
