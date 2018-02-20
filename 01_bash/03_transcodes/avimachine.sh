#!/bin/bash

IFS=$'\n'

# --- find and encode h264 avi ---

for f in $(find . -type f -iname "*.mov"); do

 	echo "$f"

	ffmpeg -y -i "$f" -c:v libx264 -b:v 2000k -profile:v main -pix_fmt yuv420p -c:a libmp3lame -b:a 192k -f avi "${f}.avi"

done


# --- rename to avi and put in subdir --- #

	mkdir ./avi/

 for name in $(find . -name "*mov.avi" -or -name "*.mov-*"); do
		mv "${name}" "./avi/${name/.mov/}"

done
