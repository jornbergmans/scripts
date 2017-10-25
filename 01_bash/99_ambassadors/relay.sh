#!/bin/bash

IFS=$'\n'

f=$1
a=$2
fname="${f##*/}"
aname="${a##*/}"
basef="${fname%.*}"
basea="${aname%.*}"
date=$(date +%Y%m%d)
time=$(date +%H%M)

if [ -z "${1+x}" ]; then
	echo "
	This script creates an audio relay from a master video and audio file.
	Please enter input files in the following order:
	1. Input video - stream 1
	2. Input audio - stream 2
	3. Preview video bitrate
	4. Destination folder
	The output will be placed in the destination folder as both a Master (.mov) and Preview (.mp4) file.
	"

elif [ "$3" != mov ]; then
	mkdir -p $4
		ffmpeg -hide_banner -y -i "$4/$basef--$basea--$date.mov" \
			-c:v libx264 -c:a aac -b:v "$3"k -b:a 256k \
			-profile:v high -level 41 -pix_fmt yuv420p \
			-f mp4 "$4/$basef--$basea--$date-$time.mp4"
elif [ "$3" == mov ]; then
	mkdir -p $4
		ffmpeg -hide_banner -i "$f" -i "$a" \
		-c:v copy -map 0:0 -map 1:0 -c:a copy \
		"$4/$basef--$basea--$date.mov"
fi
