#/bin/bash

IFS=$'\n'

# if [ -z "$1" ]; then
	echo "
	Please enter input info in the following order:
	1. Input file or folder"
	read 1
	echo "2. Video Codec (specify 'vn' if the file is audio only)"
	read 2
	echo "3. Video Bitrate"
	read 3
	echo "4. Audio Codec (specify 'an' is the file is video only)"
	read 4
 	echo "5. Audio Bitrate"
	read 5
	echo "6. Destination format"
	read 6
	echo "7. Destination folder"
	read 7

# else

	vf=$(find $inFolder -type f -iname "*.mov" -o -iname "*.mp4" -o -iname "*.mxf" -o -iname "*.avi" -o -iname "*.wmv")
		for f in $vf; do
		basef=$(basename "$f")

			if [ \( "$2" == "vn" \) ] || [ \( -z "$2" \) ]; then
				ffmpeg -i -c:a $4 -b:a $5 -f $6 $7/$basef-audio.$6
			elif  [ \( "$4" == "an" \) ] || [ \( -z "$4" \) ]; then
				ffmpeg -i $f -c:v $2 -b:v $3 -f $6 $7/$basef-mute.$6
			else
				ffmpeg -i $f -c:v $2 -b:v $3 -c:a $4 -b:a $5 -f $6 $7/$basef-audio.$6
			fi

		done
# fi
