#!/bin/bash

# # #
IFS=$'\n'

zipdir=$1

debug=$2
if [[ -n "$debug" ]]; then
	debug=$2
else
	debug=debug
fi
# # #
if [ $debug = debug ] ; then
      echo "Debug mode on. Checking for folders to zip, please wait..."
else  echo "Running live mode, please wait..."
fi

# # #
for zipfolder in $(find $zipdir -depth -type d); do

filelist=$(find $zipfolder -mindepth 1 -maxdepth 1 -type f -size -80M -and -not -iname ".*" -and -not -iname "*.zip")
basezips=$(basename "$zipfolder")
count=$(find $zipfolder -mindepth 1 -maxdepth 1 -type f -size -80M -not -iname ".*" -and -not -iname "*.zip" | wc -l)

   	if [[ $count -gt 20 ]]; then

   	  if [ $debug = debug ] ; then
        echo " "
        echo "I would zip $zipfolder because it has $count files in it"
    	  else
        	if [ -e $zipfolder/$basezips.zip ]
				then
		   		echo "Zip file $basezips.zip already exists, skipping."
      		else
        		echo "Zipping $count files in $zipfolder, please wait..."
	        		zip -q -j1 $zipfolder/$basezips.zip $filelist \;
							#depricated	zip -r0 	  $zipfolder/$basezips.zip $filelist
       			echo "Zip of $zipfolder completed!"
       	  	fi
       echo "Truncating files"
       for files in $filelist; do
					rm -f $files
			 done
   	  fi

    fi

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
