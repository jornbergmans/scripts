#!/bin/bash

IFS=$'\n'

mp4s=$(find . -type f -iname "*.mp4")

for f in $mp4s; do
				ffmpeg 		-y -i "$f" -c:v copy -c:a copy \
				-f mov ${f/.mp4/.mov} ;
done

mkdir -p ./mov/

movs=$(find . -type f -iname "*.mov")

for m in $movs; do
		mv "$m" ./mov/
done
