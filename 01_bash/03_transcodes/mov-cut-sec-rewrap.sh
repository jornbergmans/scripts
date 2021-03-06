#!/bin/bash

IFS=$'\n'

if [[ -z "$1" ]]; then
    echo "Please input the folder containing your video files"
else
    if [[ -f $1 ]]; then
       	ffmpeg -ss 00:01.000 -y -i "$1" -c:v copy -c:a copy ${1/./-min1.} ;
    elif [[ -d $1 ]]; then
        for f in "$1/"*.{mov,mkv,avi,mp4,wmv,webm,aiff,wav,aif}; do
            ffmpeg -ss 00:01.000 -y -i "$f" -c:v copy -c:a copy ${f/./-min1.} ;
        done
    fi
fi
