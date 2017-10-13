#/bin/bash

IFS=$'\n'

# f=$1

if [ -z "$1" ]; then
	echo "
	First variable not set. Please enter input info in the following order:
	1. Input file or folder
	2. Video Codec (specify 'vn' if the file is audio only)
	3. Video Bitrate
	4. Audio Codec (specify 'an' is the file is video only)
 	5. Audio Bitrate
	6. Destination format
	7. Destination folder
	"

else

	for $f in $(find $1 -type f -iname "*.mov" -o -iname "*.mp4" -o -iname "*.mxf" -o -iname "*.avi" -o -iname "*.wmv"); do

	basef=$(basename "$f")

		if [ \( "$2" -eq vn \) -o \( -z "$2" \) ]; do
			ffmpeg -i -c:a $4 -b:a $5 -f $6 $7/$basef-audio.$6
		elif  [ \( "$4" -eq an \) -o \( -z "$4" \) w]; do
			ffmpeg -i $f -c:v $2 -b:v $3 -f $6 $7/$basef-mute.$6
		else
			ffmpeg -i $f -c:v $2 -b:v $3 -c:a $4 -b:a $5 -f $6 $7/$basef-audio.$6
		fi

	done
