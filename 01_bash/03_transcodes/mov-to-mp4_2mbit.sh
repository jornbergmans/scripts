#!/usr/bin/env bash

IFS=$'\n'

infolder=$(echo $1 | sed 's/^[ \t]*//;s/\/[ \t]*$//')
outfolder=$2

inFiles=$(find "$infolder" -type f -iname "*.mov")

for f in $inFiles; do

		basef=$(basename $f)
		echo "$f"
		ffmpeg -hide_banner -loglevel panic -stats -y -i "$f" -c:v libx264 -b:v 2000k -c:a libfdk_aac -b:a 96k \
		-pix_fmt yuv420p -profile:v main -level 3.1 -f mp4 $outfolder/${basef/.mov/-ref.mp4} ;
		echo " "
done

echo "Reference videos created."
echo "Remove original movie files?"
echo " "

PS3="Select: "
options=("Yes" "No" "Quit")

select opt in "${options[@]}"
do
    case $opt in
        "Yes")
	        echo "Removing original files. Please wait."
						for rmf in $inFiles; do
						/bin/rm -fv "$rmf"
						done
	  			echo "Originals have been removed. Exiting."
					break
		    ;;
        "No")
          echo "Retaining original files. Exiting."
					break
        ;;
        "Quit")
					break
        ;;
        *) echo invalid option;;
    esac
done
