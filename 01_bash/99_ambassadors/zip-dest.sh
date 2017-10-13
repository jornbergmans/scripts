#!/bin/bash
IFS=$'\n'

# # #

zipdir=$1
dest=$2

debug=$4
if [[ -n "$debug" ]]; then
	debug=$4
else
	debug=debug
fi

if [[ $debug = debug ]] ; then
  echo "Debug mode on. Checking for folders to zip, please wait..."
# elif [[ $debug = "true|false|live" ]] ; then
# 	echo "Running script in live mode, please wait..."
fi

for zipfolder in $(find $zipdir -depth -type d); do

filelist=$(find $zipfolder -mindepth 1 -maxdepth 1 -type f -and -iname "*$3*" -and -not -iname ".*" -and -not -iname "*.zip")
count=$(find $zipfolder -mindepth 1 -maxdepth 1 -type f -and -iname "*$3*" -and -not -iname ".*" -and -not -iname "*.zip" | wc -l)

basedest=$(basename "$zipfolder")
dirdest=$(dirname "$zipfolder")
zipname=$(basename "$dirdest")
#basedest=$(echo $zipfolder | sed 's:/Volumes/::')

#   	if [[ $count -gt 20 ]]; then

			# echo "basedest = $basedest"
			# echo "dirdest = $dirdest"
			# echo "zipname = $zipname"
			# echo "full name will be $dest/$zipname/$zipname-$basedest.zip"
			# fi

   	  if [[ $debug = debug ]] ; then
        echo " "
        echo "I will archive $count files in $zipfolder that contain the string \"$3\""
    	  else
        	if [[ -f $dest/$zipname/$zipname-$basedest.zip ]]
				then
		   		echo "Zip file $dest/$zipname/$zipname-$basedest.zip already exists, skipping."
      		echo " "
				else
      			mkdir -p $dest/$zipname/
        		echo "Zipping $count files in $zipfolder, please wait..."
#        		for files in $filelist; do
	        		zip -jq1 $dest/$zipname/$zipname-$basedest.zip $filelist \;
#	    		done
				#depricated	zip -r0 	  $zipfolder/$basezips.zip $filelist
       			echo "Zip of $zipfolder completed!"
						echo "The file can be found at $dest/$zipname/$zipname-$basedest.zip"
						echo " "
       	  	fi
							if [[ $3 = png ]] || [[ $3 = dpx ]] || [[ $3 = exr ]] || [[ $3 = tif* ]] || [[ $3 = jp*g ]]; then
					      if [[ ! -f $dest/$zipname/$zipname-$basedest.mp4 ]]
									then
										echo "A reference file will be created at $dest/$zipname/$zipname-$basedest.mp4"
										ffmpeg -hide_banner -loglevel panic -pattern_type glob \
										-y -i "$zipfolder/*.$3" -c:v libx264 -b:v 2500k \
										-pix_fmt yuv420p -r 25 -f mp4 "$dest/$zipname/$zipname-$basedest.mp4"
										echo " "
								fi
							# else
							# 	echo "Files are not images, no reference video will be created for zipfile."
						 fi
       # echo "Truncating files"
       # $filelist -delete
   	  fi

#    fi

done

echo " "
echo "Nothing else to do!"

# # # CODE FROM OLD VERSION # # #
# function 	count {
#   				[[ $(find $zipfolder -mindepth 1 -maxdepth 1 -type f  | wc -l) ]]
#   	}
#
# filelist=$(find $zipfolder -mindepth 1 -maxdepth 1 -type f)
#         #
#         # echo $filelist
#         echo ${#filelist[@]}


## Make a video from an image sequence with 4 trailing digits:
## ffmpeg -y -i /foo/bar_%04d.png -c:v libx264 -b:v 2500k -pix_fmt yuv420p -r 25 -f mp4 /foo/bar.mp4

## or with no trailing digits or regular pattern:
## ffmpeg -y -i /foo/bar*.png -c:v libx264 -b:v 2500k -pix_fmt yuv420p -r 25 -f mp4 /foo/bar.mp4
