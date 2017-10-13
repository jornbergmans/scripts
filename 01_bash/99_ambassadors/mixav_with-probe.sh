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

mkdir -p "$4/$dirv"

	for v in $(find $movfolder -maxdepth 1 -type f -iname "*.mov" -o -iname "*.mp4" -o -iname "*.mxf"); do
		durv=$(ffprobe -v error -hide_banner -show_entries format=duration -of default=noprint_wrappers=1:nokey=1 -sexagesimal $v)
basev=$(basename "$v")
dirv=$(dirname "$v")
		for numa in $(find $dirv -type f -iname "*.aif*" -o -iname "*.wav" | wc -l); do
			if [[ $numa -gt 0 ]]; then
				for a in $(find $dirv -type f -iname "*.aif*" -o -iname "*.wav"); do
basea=$(basename "$a")
dura=$(ffprobe -v error -hide_banner -show_entries format=duration -of default=noprint_wrappers=1:nokey=1 -sexagesimal $a)
					if [[ "$dura" = "$durv" ]]; then
						ffmpeg -hide_banner -y -i $v -i $a -c:v copy -map 0:0 -map 1:0 -c:a copy $4/$basev-$basea-$date.$3
					else
						echo "Audio file duration of $basea does not match Video file duration of $basev;"
						echo "$basea has a duration of $dura, where $basev has a duration of $durv"
					fi
				done
			else
				for a in $(find $2 -type f -iname "*.aif*" -o -iname "*.wav" ); do
basea=$(basename "$a")
dura=$(ffprobe -v error -hide_banner -show_entries format=duration -of default=noprint_wrappers=1:nokey=1 -sexagesimal $a)
					if [[ "$dura" = "$durv" ]]; then
						ffmpeg -hide_banner -y -i $v -i $a -c:v copy -map 0:0 -map 1:0 -c:a copy $4/$basev-$basea-$date.$3
					else
						echo "Audio file duration of $basea does not match Video file duration of $basev;"
						echo "$basea has a duration of $dura, where $basev has a duration of $durv"
					fi
				done
			fi
		# namech=$(find $4 -type f -iname "*.$3")
		# while read -r $namech; do
		# mv "${namech}" ${namech/.mov-/-}
		# done
	done
done
fi
