#!/bin/bash

IFS=$'\n'

echo "Please input file"
	read inFile
	inVid=$(echo "$inFile" | sed 's/^[ \t]*//;s/[ \t]*$//')
if [[ -f ${inVid} ]]; then
	echo "Thank You. Reading from file $inVid"
	echo " "
	echo "Please input desired thumbnail interval in seconds"
	read inRate
	echo "Setting interval to 1 frame every $inRate seconds."
	echo " "
	echo "Would you like the thumbnail images to be padded? (yes/no)"
	read inPad
	echo "Thank you."
	echo "Creating thumbnail image..."

	bdIn=$(dirname "$inVid")
	baseIn=$(basename "$inVid")

	inFrames=$(	ffprobe -hide_banner -loglevel panic -pretty \
							-select_streams v:0 -show_entries stream=nb_frames \
							-of default=noprint_wrappers=1:nokey=1 -i $inVid)
	outToGrab=$(echo "$inFrames/$inRate" | bc)
	outFrames=$(echo "$outToGrab/25" | bc)
	tileHeight=$(echo "scale=2;$outFrames/4" | bc | xargs printf %.0f )

	mkdir -p "$bdIn/.ff_thumb"

	ffmpeg 	-hide_banner -loglevel panic \
					-i $inVid -vf fps="1/$inRate",scale='480:-1' \
					"$bdIn/.ff_thumb/$baseIn-%03d.tiff"
		if [[ $inPad == "no" ]] || [[ $inPad == "n" ]] || [[ $inPad == "N" ]]; then
						ffmpeg 	-hide_banner -loglevel panic \
										-pattern_type glob -y -i "$bdIn/.ff_thumb/$baseIn-*.tiff" \
										-frames 1 \
										-vf tile=4x$tileHeight:margin=0:padding=0 \
										$bdIn/$baseIn-thumb.tiff
						ffmpeg 	-hide_banner -loglevel panic \
										-pattern_type glob -y -i "$bdIn/.ff_thumb/$baseIn-*.tiff" \
										-frames 1 \
										-vf tile=4x$tileHeight:margin=0:padding=0 \
										$bdIn/$baseIn-thumb.png
		elif [[ $inPad == "yes" ]] || [[ $inPad == "y" ]] || [[ $inPad == "Y" ]]; then
						ffmpeg 	-hide_banner -loglevel panic \
										-pattern_type glob -y -i "$bdIn/.ff_thumb/$baseIn-*.tiff" \
										-frames 1 \
										-vf tile=4x$tileHeight:margin=4:padding=4 \
										$bdIn/$baseIn-thumb.tiff
						ffmpeg 	-hide_banner -loglevel panic \
										-pattern_type glob -y -i "$bdIn/.ff_thumb/$baseIn-*.tiff" \
										-frames 1 \
										-vf tile=4x$tileHeight:margin=4:padding=4 \
										$bdIn/$baseIn-thumb.png
		fi

	rm -Rf "$bdIn/.ff_thumb"

	echo " "
	echo "Thumbnail output file created at $bdIn/$baseIn-thumb.png"
else
	echo "$inVid is not a valid file. Please restart and input a valid source video file."
	exit 1
fi
