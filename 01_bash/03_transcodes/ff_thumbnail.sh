#!/bin/bash

IFS=$'\n'

if [ -z "${1+x}" ] || [ -z "${2+x}" ]; then
	echo "	Please input source video and desired interval in seconds.
	(i.e. an interval of 1 would create a thumbnail for every second,
	whereas an interval of 60 would create a thumbnail for every minute of video)"

else

inVid=$1
inRate=$2
bdIn=$(dirname $inVid)
baseIn=$(basename $inVid)

inFrames=$(	ffprobe -hide_banner -loglevel panic -pretty \
						-select_streams v:0 -show_entries stream=nb_frames \
						-of default=noprint_wrappers=1:nokey=1 -i $inVid)
outToGrab=$(echo "$inFrames/$inRate" | bc)
outFrames=$(echo "$outToGrab/25" | bc)
tileHeight=$(echo "scale=2;$outFrames/4" | bc | xargs printf %.0f )


mkdir -p "$bdIn/.ff_thumb"

ffmpeg 	-hide_banner -loglevel panic \
				-i $inVid -vf fps="1/$inRate",scale='320:-1' \
				"$bdIn/.ff_thumb/$baseIn-%03d.png"
ffmpeg 	-hide_banner -loglevel panic \
				-pattern_type glob -y -i "$bdIn/.ff_thumb/$baseIn-*.png" \
				-frames 1 \
				-vf tile=4x$tileHeight:margin=4:padding=4 \
				$bdIn/$baseIn-thumb.png

rm -Rf "$bdIn/.ff_thumb"

fi
