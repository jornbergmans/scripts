#!/bin/bash

IFS=$'\n'

movfolder=$(find $1 -mindepth 1 -type d)

date=$(date +%Y%m%d-%H%M)

if [ -z "$1" ]; then
	echo "
	First variable not set. Please enter input files in the following order:
	1. Input video file - stream 1
	2. Input audio folder - stream 2
	3. Destination format - mp4, mov, flv, etc
	4. Destination folder
	"

else

	mkdir -p $4

v=$(find $movfolder -maxdepth 1 -type f -iname "*.mov" -o -iname "*.mp4" -o -iname "*.mxf");
while read -r $v;
 do

basev=$(basename "$v")
dirv=$(dirname "$v")

		for numa in $(find $dirv -maxdepth 1 -type f -iname "*.aif*" -o -iname "*.wav" | wc -l); do
				echo $dirv
				echo $numa
		done
			if [[ $numa -gt 0 ]]; then
				a=$(find $dirv -type f -iname "*.aif*" -o -iname "*.wav" )
				while read -r $a; do
				# for a in $(find $dirv -maxdepth 1 -type f -iname "*.aif*" -o -iname "*.wav"); do
						basea=$(basename "$a")
						ffmpeg -y -i $v -i $a -c:v copy -map 0:0 -map 1:0 -c:a copy $4/$basev-$basea-$date.$3 < /dev/null
				done
			else
				a=$(find $2 -type f -iname "*.aif*" -o -iname "*.wav" )
				while read -r $a; do
				# for a in $(find $2 -type f -iname "*.aif*" -o -iname "*.wav" ); do
					basev=$(basename "$v")
					basea=$(basename "$a")
					ffmpeg -y -i $v -i $a -c:v copy -map 0:0 -map 1:0 -c:a copy $4/$basev-$basea-$date.$3 < /dev/null
				done
			fi
	done
fi
