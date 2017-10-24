#!/bin/bash

IFS=$'\n'
date=$(date +%Y%m%d-%H%M)

# The user defines their input

if [ -z "$1" ]; then
	echo "
	First variable not set. Please enter input files in the following order:
	1. Input video file - stream 1
	2. Input audio folder - stream 2
	3. Destination format - mp4, mov, flv, etc
	4. Destination folder
	"

else

# We check if the input provided is a folder with subfolders,
# a folder with a file, or a single file.
# i.e. we check if there's folders inside of var '1'

foldercount=$(find "$1" -mindepth 1 -type d -and -not -iname ".*" | wc -l )
if [[ $foldercount -gt 0 ]]; then
	movfolder=$(find "$1" -mindepth 1 -type d -and -not -iname ".*" );
else
	movfolder=$(find "$1" -maxdepth 1 -type f -iname "*.mov" -o -iname "*.mp4" -o -iname "*.mxf" -and -not -iname ".*" )
fi

# We check if there's already a relay with the same name.
# If not, let's create a file!
	if [ ! -e "$4/video-$basev--audio-$basea--date-created-$date.$3" ]; then

# First we check if the input was a folder with video files,
# or maybe just a single video file, and fill var 'v' with a list of files
		if [ ! $foldercount -gt 0 ]; then
 			vf=$(find "$movfolder" -maxdepth 1 -type f -iname "*.mov" -o -iname "*.mp4" -o -iname "*.mxf" -and -not -iname ".*")
			for v in $vf; do
			vname="${v##*/}"
			basev="${vname%.*}"
			dirv=$(dirname "$v")
			mkdir -p "$4/$dirv"
			done
		else
			for v in $movfolder; do
			basev=$(basename "$v")
			dirv=$(dirname "$v")
			mkdir -p "$4/$dirv"
			done
		fi

# Then we can start finding the matching audio files
			numa=$(find "$dirv" -maxdepth 1 -type f -iname "*.aif*" -o -iname "*.wav" -and -not -iname ".*" | wc -l)

# If there is audio in the same folder as the video file (afilecount greater than 0),
# use those audio files for the relay
				if [[ "$numa" -gt 0 ]]; then
					af=$(find "$dirv" -maxdepth 1 -type f -iname "*.aif*" -o -iname "*.wav" -and -not -iname ".*" )
					for a in $af; do
							aname="${a##*/}"
							basea="${aname%.*}"
							ffmpeg -hide_banner -y -i "$v" -i "$a" -c:v copy -map 0:0 -map 1:0 -c:a copy "$4/video-$basev--audio-$basea--date-created-$date.$3"
					done
# If there is no audio in the same folder, search the second input variable for audio files to use
				else
					af=$(find "$2" -type f -iname "*.aif*" -o -iname "*.wav" -and -not -iname ".*" )
					for a in $af; do
						basea=$(basename "$a")
						ffmpeg -hide_banner -y -i "$v" -i "$a" -c:v copy -map 0:0 -map 1:0 -c:a copy "$4/video-$basev--audio-$basea--date-created-$date.$3"
					done
				fi
		fi
fi
