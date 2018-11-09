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
if [[ -z $1 ]] || [[ -z $2 ]] || [[ -z $3 ]]; then
	echo "Please input folder"
	read inputfolder
	echo "Please input desired output framerate"
	read outputrate
	echo "Please input desired output height in pixels. (input -1 for original size)"
	read rez
	echo "Do you want to enable debug mode? y/n"
	select yn in "Yes" "No"; do
		case $yn in
			Yes ) debug=y; break;;
			No) debug=n; break;;
		esac
	done
else
	inputfolder="$1"
	outputrate="$2"
	rez="$3"
	debug="$4"
fi

echo "Input set, creating file list"

inputfolder=$(echo "$inputfolder" | sed 's/[[:space:]]$//;s:\/$::')
filelist=$(find "$inputfolder" -iname "*.mov" -or -iname "*.mp4" -or -iname "*.mkv" -or -iname "*.avi" -or -iname "*.wmv" -or -iname "*.mxf" -and -not -iname "._*")

if [[ $rez = '-1' ]]; then
	rezname='original-resolution_'
else
	rezname="$rez"
fi

 for f in $filelist; do
 	 basef=$(basename "$f")
	 dirf=$(dirname "$f")
	 outputdir="$dirf"/gif-"$rezname"p"$outputrate"
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
#		 echo "Creating palette for $basef"
				ffmpeg -hide_banner -loglevel panic -y -i "$f" -vf fps=10,scale=-1:1080:flags=lanczos,palettegen "$outputdir"/."${basef/.mov/_palette.png}"
		 echo "Creating GIF file at $outputrate frames per second"
				ffmpeg -hide_banner -loglevel panic -y -i "$f" -i "$outputdir"/."${basef/.mov/_palette.png}" -filter_complex \
				"fps=$outputrate,scale=-1:$rez:flags=lanczos[x];[x][1:v]paletteuse" -f gif "$outputdir/${basef/.mov/_"$rezname"p"$outputrate".gif}"
		 if [[ ! "$debug" = '' ]] || [[ "$debug" = 'n' ]]; then
			rm -f "$outputdir"/."${basef/.mov/_palette.png}"
		 fi
		 if [[ -f "$outputdir/${basef/.mov/_"$rezname"p"$outputrate".gif}" ]]; then
			 echo "GIF file created at $outputdir/${basef/.mov/_"$rezname"p"$outputrate".gif}"
	 	 elif [[ ! -f "$outputdir/${basef/.mov/_"$rezname"p"$outputrate".gif}" ]]; then
		 	 echo "Output file not found, please run in debug mode."
		 fi
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
