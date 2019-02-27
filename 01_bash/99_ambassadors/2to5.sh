#!/usr/bin/env bash

front_left="$1"
front_right="$2"
front_center="$3"
lfe="$4"
back_left="$5"
back_right="$6"
outputname="$7"

if [[ -z $1 ]] || [[ -z $2 ]] || [[ -z $3 ]]; then
  echo "Input Left channel"
	read front_left
  echo "Input Right channel"
	read front_right
  echo "Input Center channel"
	read front_center
  echo "Input LFE channel"
	read lfe
  echo "Input Left Surround channel"
	read back_left
  echo "Input Right Surround channel"
	read back_right
  echo "Input export filename"
  read outputname
fi

echo "$front_left"
echo "$front_right"
echo "$front_center"
echo "$lfe"
echo "$back_left"
echo "$back_right"


ffmpeg -i "$front_left" -i "$front_right" -i "$front_center" -i "$lfe" -i "$back_left" -i "$back_right" \
  -filter_complex "[0:a][1:a][2:a][3:a][4:a][5:a]join=inputs=6:channel_layout=5.1[a]" \
  -map "[a]" "$outputname"
