#!/usr/bin/env bash

IFS=$'\n'


# 	echo "
# 	First variable not set. Please enter input info in the following order:
# 	1. Input file or folder
# 	2. Output framerate
# 	3. Output height in pixels
# 	4. Debug mode enables
# 	"
#
# else
if [ -z "$1" ]; then
	echo "Please input folder"
	read inputfolder
	echo "Please input desired output framerate"
	read outputrate
	echo "Please input desired output height in pixels"
	read rez
	echo "Do you want to enable debug mode? y/n"
	read debug
else
	inputfolder="$1"
	outputrate="$2"
	rez="$3"
	debug="$4"
fi
filelist=$(find "$inputfolder" -iname "*GIF*.mov" -not -iname "._*")

 for f in $filelist; do
 	 basef=$(basename "$f")
	 dirf=$(dirname "$f")
	 outputdir="$dirf"/gif-"$rez"p"$outputrate"
	 mkdir -p "$outputdir"
		if [[ ! "$debug" = '' ]] && [[ "$debug" = 'y' ]]; then
		 echo "- - - -"
		 echo "Debug mode enabled, listing input / output"
		 echo "- - - -"
		 echo "f is $f"
		 echo "outputdir is $outputdir"
		 echo "dirf is $dirf"
		 echo "basef is $basef"
		 echo "- - - -"
 		else
		 echo "Creating palette for $basef"
				ffmpeg -hide_banner -loglevel panic -y -i "$f" -vf fps=10,scale=-1:1080:flags=lanczos,palettegen "$outputdir/${basef/.mov/_palette.png}"
		 echo "Creating GIF file at $2 frames per second"
				ffmpeg -hide_banner -loglevel panic -y -i "$f" -i "$outputdir"/"${basef/.mov/_palette.png}" -filter_complex \
				"fps=$outputrate,scale=-1:$rez:flags=lanczos[x];[x][1:v]paletteuse" -f gif "$outputdir/${basef/.mov/_"$rez"p"$outputrate".gif}"
		 echo "GIF file created at $outputdir/${basef/.mov/_"$rez"p"$outputrate".gif}"
		 echo ""
	 	fi
done

#for name in $(find $1/gif-$3/ -iname "*mov.gif"); do
#		mv "${name}" ${name/mov.gif/gif}
#done
#
# for gif in $(find $1 -type f -and -iname "*.gif" -or -iname "*palette*.png"); do
# 		mv "$gif" $1/gif-$3/
# done
#
# fi
