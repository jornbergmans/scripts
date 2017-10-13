#!/bin/bash

IFS=$'\n'

if [ -z "$1" ]; then
	echo "
	First variable not set. Please enter input info in the following order:
	1. Input file or folder
	2. Output framerate
	3. Output height in pixels
	"

else

mkdir -p $1/gif-$3

for f in $(find $1 -iname "*GIF*.mov" -not -iname "._*"); do
	basef=$(basename $f)
		ffmpeg -y -i $f -vf fps=10,scale=-1:1080:flags=lanczos,palettegen $1/gif-$3/$basef-palette.png

		ffmpeg -y -i $f -i $1/gif-$3/$basef-palette.png -filter_complex \
		"fps=$2,scale=-1:$3:flags=lanczos[x];[x][1:v]paletteuse" -f gif $1/gif-$3/$basef.gif
done

for name in $(find $1/gif-$3/ -iname "*mov.gif"); do
		mv "${name}" ${name/mov.gif/gif}
done
#
# for gif in $(find $1 -type f -and -iname "*.gif" -or -iname "*palette*.png"); do
# 		mv "$gif" $1/gif-$3/
# done

fi
