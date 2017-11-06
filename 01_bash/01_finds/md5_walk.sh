#!/bin/bash
IFS=$'\n'

checkfolder=$(find "$1" -type f)
sourcefolder=$2

for checkfile in $checkfolder; do

  basefile=$(basename "$checkfile")
  # checkpath=$(dirname "$checkfile")
  # basepath=$(basename "$checkpath")
  # echo $basefile
  # echo $checkpath
  # echo $basepath

  sourcefile=$(find "$sourcefolder" -type f -iname "$basefile")
  # echo $sourcefile

    checkhash=$(md5 -q "$checkfile")
    sourcehash=$(md5 -q "$sourcefile")

    if [[ "$checkhash" != "$sourcehash" ]]; then
      echo "Checksum for '$checkfile' does not equal checksum for '$sourcefile'."
    fi

done
