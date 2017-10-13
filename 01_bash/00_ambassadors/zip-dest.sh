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

if [ $debug = debug ] ; then
  echo "Debug mode on. Checking for folders to zip, please wait..."
fi

# # #
for zipfolder in $(find $zipdir -depth -type d); do

filelist=$(find $zipfolder -mindepth 1 -maxdepth 1 -type f -size -80M -and -iname "*$3*" -and -not -iname ".*" -and -not -iname "*.zip")
count=$(find $zipfolder -mindepth 1 -maxdepth 1 -type f -size -80M -not -iname ".*" -and -not -iname "*.zip" | wc -l)

basedest=$(basename "$zipfolder")
dirdest=$(dirname "$zipfolder")
zipname=$(basename "$dirdest")
#basedest=$(echo $zipfolder | sed 's:/Volumes/::')


echo "basedest = $basedest"
echo "dirname = $dirname"
echo "zipname = $zipname"
echo "full name will be $dest/$zipname/$zipname-$basedest.zip"
#    	if [[ $count -gt 20 ]]; then
#
#    	  if [ $debug = debug ] ; then
#         echo " "
#         echo "I will zip $zipfolder because it has $count files in it"
#     	  else
#         	if [ -e $dest/$zipname/$zipname-$basedest.zip ]
# 				then
# 		   		echo "Zip file $dest/$zipname/$zipname-$basedest.zip already exists, skipping."
#       		else
#       			mkdir -p $dest/$dirdest/
#         		echo "Zipping $count files in $zipfolder, please wait..."
# #        		for files in $filelist; do
# 	        		zip -jq1 $dest/$zipname/$zipname-$basedest.zip $filelist \;
# #	    		done
# 				#depricated	zip -r0 	  $zipfolder/$basezips.zip $filelist
#        			echo "Zip of $zipfolder completed!"
# 						echo "The file can be found at $dest/$zipname/$zipname-$basedest.zip"
#        	  	fi
#        # echo "Truncating files"
#        # $filelist -delete
#    	  fi
#
#     fi

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
