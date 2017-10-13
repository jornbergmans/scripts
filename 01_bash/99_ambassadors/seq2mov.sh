#!/bin/bash

IFS=$'\n'

basedir=$(dirname $1)

if [ -z "${1+x}" ]; then
	echo "
    This script will create a movie file from an image sequence.
    Please enter input in the following order:
    1. Input folder containing image sequence
    2. Image sequence format (jpg, png, dpx)
		3. Input audio file
		4. Select 'master' for a ProRes output, or 'ref' for mp4 output
"

  if [[ $4 = "master" ]]; then
    ffmpeg -hide_banner -loglevel panic -pattern_type glob \
    -y -i "$1/*.$2" -map 0:0 -c:v prores_ks -profile:v 4444 -b:v 40000k \
		-i "$3" -map 1:0 -c:a pcm_s24le \
    -pix_fmt yuv444p10le -r 25 -f mov "$1/$basedir.mov"
  elif [[ $4 = "ref" || $4 = "proxy" ]]; then
    ffmpeg -hide_banner -loglevel panic -pattern_type glob \
    -y -i "$1/*.$2" -c:v libx264 -b:v 2500k \
		-i "$3" -map 1:0 -c:a aac -b:a 160k \
    -pix_fmt yuv420p -r 25 -f mp4 "$1/$basedir.mp4"
  fi
fi
