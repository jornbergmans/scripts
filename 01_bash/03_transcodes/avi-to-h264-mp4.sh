#!/bin/bash

IFS=$'\n'

avis=$(find . -type f -iname "*.avi")

for ss_avi in $avis; do

		ffmpeg -y -i "$ss_avi" -c:v libx264 -c:a libfdk_aac \
		-pix_fmt yuv420p -profile:v high -level 41 -f mp4 ${ss_avi/.avi/.mp4} ;

done
