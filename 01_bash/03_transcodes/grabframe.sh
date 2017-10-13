#!/bin/bash

IFS=$'\n'

input=$(find $1 -type f -iname "*.mxf" -and -not -iname "._*")
for f in $input; do

basef=$(basename $f)
#dirf=$(dirname $f)
# echo $f
# echo $basef
mkdir -p "$2"

ffmpeg -ss 00:20.000 -y -i "$f" -t 0.040 -c:v:0 png -an "$2/$basef.png"

done

echo "done"
