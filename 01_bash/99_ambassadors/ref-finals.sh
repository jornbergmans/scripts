#!/bin/bash

IFS=$'\n'

debug=$2

if [[ -n "$debug" ]]; then
	debug=$2
else
	#echo 'debug mode'
	debug=true
fi

if [ "$debug" = false ] ; then
    echo 'debug mode off!'
else
		echo 'running in debug mode.'
fi

# function refs {

if [[ "$1" = */*_archive/* ]]; then
  echo "Archive check passed"


  if [ -d "$1" ]; then
    echo "Folder check passed"
	fin_list=$(find "$1" -depth -type f -and -iname "*.mov" -or -iname "*.mxf" -and -not -iname "._*" )
			for fin in $fin_list; do

				if [ "$debug" = false ] ; then
					echo "Creating reference file for $fin"
					ffmpeg -hide_banner -loglevel error -y -i "$fin" -c:v libx264 -b:v 1500k -c:a aac -strict 2 -b:a 96k \
					-pix_fmt yuv420p -profile:v main -level 3.1 -f mp4 $fin-ref.mp4 ;

					rm -f "$fin"
				else
					echo "Transcode of $fin to reference file"
				fi
			done

			for rename in $(find "$1" -name "*.mov-ref*"); do
						mv "${rename}" ${rename/.mov/}
			done

  else
    echo "argument error: Folder check failed"
  fi

else
  echo "argument error: Archive check failed"
fi
