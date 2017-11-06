#!/bin/bash
IFS=$'\n'

checkfolder=$(find "$1" -type f)
sourcefolder=$2

for checkfile in $checkfolder; do

  basefile=$(basename "$checkfile")
  basepath=$(dirname "$checkfile")
  # echo $basefile

  sourcefile=$(find "$sourcefolder" -type f -ipath "$basepath" -iname "$basefile")
  # echo $sourcefile

    checkhash=$(md5 -q "$checkfile")
    sourcehash=$(md5 -q "$sourcefile")

    if [[ "$checkhash" != "$sourcehash" ]]; then
      echo "Checksum for '$checkfile' does not equal checksum for '$sourcefile'."
    fi

done
