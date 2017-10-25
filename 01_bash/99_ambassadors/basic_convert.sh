#!/bin/bash

IFS=$'\n'

# if [ -z "$1" ]; then
	echo "
	Please enter input info in the following order:
	1. Input file or folder"
	read inFolder
	inFile=$(echo "$inFolder" | sed 's/^[ \t]*//;s/[ \t]*$//')
	echo "2. Video Codec (specify 'vn' if the file is audio only)"
	read vCodec
	echo "3. Video Bitrate"
	read vRate
	echo "4. Audio Codec (specify 'an' is the file is video only)"
	read aCodec
 	echo "5. Audio Bitrate"
	read aRate
	echo "6. Destination format"
	read outFormat
	echo "7. Destination folder"
	read outFolder

# else

	vf=$(find "$inFile" -type f -iname "*.mov" -o -iname "*.mp4" -o -iname "*.mxf" -o -iname "*.avi" -o -iname "*.wmv")
		for f in $vf; do
		basef=$(basename "$f")

			if [ \( "$vCodec" == "vn" \) ] || [ \( -z "$vCodec" \) ]; then
				ffmpeg -i -c:a $aCodec -b:a $aRate -f $outFormat $outFolder/$basef-audio.$outFormat
			elif  [ \( "$aCodec" == "an" \) ] || [ \( -z "$aCodec" \) ]; then
				ffmpeg -i $f -c:v $vCodec -b:v $vRate -f $outFormat $outFolder/$basef-mute.$outFormat
			else
				ffmpeg -i $f -c:v $vCodec -b:v $vRate -c:a $aCodec -b:a $aRate -f $outFormat $outFolder/$basef-audio.$outFormat
			fi

		done
# fi
