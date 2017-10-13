#!/bin/bash
IFS=$'\n'

# # #

zipdir=$1

dest=$2

debug=$3
if [[ -n "$debug" ]]; then
	debug=$3
else
	debug=debug
fi

if [ $debug = debug ] ; then
  echo "Debug mode on. Checking for folders to zip, please wait..."
fi

# # #
for zipfolder in $(find $zipdir -depth -type d); do

filelist=$(find $zipfolder -mindepth 1 -maxdepth 1 -type f -size -80M -and -not -iname ".*" -and -not -iname "*.zip")
basezips=$(basename "$zipfolder")
count=$(find $zipfolder -mindepth 1 -maxdepth 1 -type f -size -80M -not -iname ".*" -and -not -iname "*.zip" | wc -l)
basedest=$(echo $zipfolder | sed 's:/Volumes/::')

   	if [[ $count -gt 20 ]]; then

   	  if [ $debug = debug ] ; then
        echo " "
        echo "I will zip $zipfolder because it has $count files in it"
    	  else
        	if [ -e $dest/$basedest/$basezips.zip ]
				then
		   		echo "Zip file $basezips.zip already exists, skipping."
      		else
      			mkdir -p $dest/$basedest/
        		echo "Zipping $count files in $zipfolder, please wait..."
#        		for files in $filelist; do
	        		zip -j1 $dest/$basedest/$basezips.zip $filelist \;
#	    		done
				#depricated	zip -r0 	  $zipfolder/$basezips.zip $filelist 
       			echo "Zip of $zipfolder completed!" 
       	  	fi
       # echo "Truncating files"
       # $filelist -delete
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
