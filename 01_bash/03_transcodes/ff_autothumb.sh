#!/usr/bin/env bash

IFS=$'\n'

echo "Please input file"
	read inFile
	inVid=$(echo "$inFile" | sed 's/^[ \t]*//;s/[ \t]*$//')
if [[ -f ${inVid} ]]; then
	echo "Thank You. Reading from file $inVid"
echo "What is your preferred thumbnail interval in seconds?"
	read inRate
echo "Setting the interval to 1 thumbnail image per $inRate seconds"

	bdIn=$(dirname "$inVid")
	baseIn=$(basename "$inVid")

	inFrames=$(		ffprobe -hide_banner -loglevel panic -pretty \
								-select_streams v:0 -show_entries stream=nb_frames \
								-of default=noprint_wrappers=1:nokey=1 -i $inVid)
	fps=$(				ffprobe -hide_banner -loglevel panic -pretty \
								-select_streams v:0 -show_entries stream=r_frame_rate -of default=noprint_wrappers=1:nokey=1 -i $inVid)
	outToGrab=$(echo "$inFrames/$inRate" | bc)
	outFrames=$(echo "$outToGrab/$fps" | bc)
	outRate=$(echo "$inFrames/$outFrames" | bc)

echo "++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
echo " "
echo "I see that the video has $inFrames frames"
echo "You have chosen to output 1 thumbnail image per $inRate seconds"
echo "That equals a thumbnail per $outRate frames"
echo "I will output a filmstrip that is $outFrames frames in width"
echo " "
echo "++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"

ffmpeg 	-hide_banner -loglevel panic \
				-y -i $inVid -frames 1 -q 5 \
				-vf "mpdecimate,select=not(mod(n\,$outRate)),scale='480:-1',tile='$outFrames'x1" \
				 "$bdIn/$baseIn-thumb.png"

	echo " "
	echo "Thumbnail output file created at $bdIn/$baseIn-thumb.png"

else
	echo "$inVid is not a valid file. Please restart and input a valid source video file."
	exit 1
fi
