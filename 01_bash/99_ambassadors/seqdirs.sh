#!/bin/bash

IFS=$'\n'

indcount=$(find $1 -mindepth 1 -type d -not -iname ".*" | wc -l)
basedir=$(basename $1)

if [ -z "${1+x}" ]; then

	echo "
    This script will create a movie file from an image sequence.
    Please enter input in the following order:
    1. Input folder containing image sequence
    2. Image sequence format (jpg, png, dpx)
    3. Select 'master' for a ProRes output, or 'ref' for mp4 output
		4. Output folder for the movie file
"
else
  if [[ $indcount -gt 0 ]]; then
  	ind=$(find "$1" -mindepth 1 -type d -and -not -iname ".*" )
      for d in $ind; do
    based=$(basename $d)
		audio=$(find $d -maxdepth 1 -type f -iname "*.wav" -or -iname "*.aif*" -and -not -iname ".*" )
				mkdir -p "$4/$basedir/$based"
				echo "Found subfolder $based in $1"
          if [[ $3 = "master" ]]; then
				echo "Creating master format movie from sequence..."
            ffmpeg -hide_banner -loglevel panic -thread_queue_size 512 -pattern_type glob -r 25 -y -i "$d/*.$2" \
						-i "$audio" -map 0:0 -map 1:0 \
            -c:a pcm_s24le -channel_layout stereo \
						-c:v prores_ks -profile:v 4444 -b:v 40000k -pix_fmt yuv444p10le \
            -r 25 -f mov "$4/$basedir/$based/$based.mov"
          elif [[ $3 = "ref" || $3 = "proxy" ]]; then
					echo "Creating reference movie from sequence..."
            ffmpeg -hide_banner -loglevel panic -thread_queue_size 512 -pattern_type glob -r 25 -y -i "$d/*.$2" \
						-i "$audio" -map 0:0 -map 1:0 \
						-c:a aac -b:a 256k -channel_layout stereo \
            -c:v libx264 -minrate 15000k -maxrate 20000k -bufsize 20000k -pix_fmt yuv420p \
            -vf "scale=trunc(iw/2)*2:trunc(ih/2)*2" \
            -r 25 -f mp4 "$4/$basedir/$based/$based.mp4"
          fi
    	done
  else
		mkdir -p "$4/$basedir"
      if [[ $3 = "master" ]]; then
		echo "Creating master format movie from sequence..."
        ffmpeg -hide_banner -loglevel panic -thread_queue_size 512 -pattern_type glob -r 25 -y -i "$1/*.$2" \
				-i "$audio" -map 0:0 -map 1:0 \
				-c:a pcm_s24le -channel_layout stereo \
        -c:v prores_ks -profile:v 4444 -b:v 40000k -pix_fmt yuv444p10le \
        -r 25 -f mov "$4/$basedir/$basedir.mov"
      elif [[ $3 = "ref" || $3 = "proxy" ]]; then
		echo "Creating reference movie from sequence..."
        ffmpeg -hide_banner -loglevel panic -thread_queue_size 512 -pattern_type glob -r 25 -y -i "$1/*.$2" \
				-i "$audio" -map 0:0 -map 1:0 \
				-c:a aac -b:a 256k -channel_layout stereo \
        -c:v libx264 -minrate 15000k -maxrate 20000k -bufsize 20000k -pix_fmt yuv420p \
        -vf "scale=trunc(iw/2)*2:trunc(ih/2)*2" \
        -r 25 -f mp4 "$4/$basedir/$basedir.mp4"
      fi
  fi
fi
