#!/bin/bash

IFS=$'\n'

f=$1
a=$2
basef=$(basename "$f")
basea=$(basename "$a")
date=$(date +%Y%m%d-%H%M)

if [ -z "${1+x}" ]; then
	echo "
	First variable not set. Please enter input files in the following order:
	1. Input video - stream 1
	2. Input audio - stream 2
	3. Destination format - mp4, mov, flv, etc
	4. Destination folder
	"

else

mkdir -p $4 && ffmpeg -i $f -i $a -c:v copy -map 0:0 -map 1:0 -c:a copy $4/$basef-$basea-$date.$3

fi
