#!/bin/bash

IFS=$'\n'
echo "Depricated Script - seek out v02 and cat"

# function clean {

# #cd */*ARCHIVED &&
# for meta in $(find $name -type f \
# 				\( 	\
# 					-and -iname "._*" \
# 					-and -iname ".DS*" \
# 					-and -iname ".afpDel*" \
# 				\) \
# 			 ); do
				
# 		     echo $meta
# 		     if [ "$debug" = false ] ; then
# 			 	rm -Rfv $meta
# 			 fi
		
# done


# for autosave in $(find $name -type d \
# 					\(	\
# 					-and -iname "*Adobe Premiere Pro Auto-Save*" \
# 					-and -iname "*Adobe Premiere Pro Video Previews" \
# 					\) \
# 				 ); do
					
					
# 					echo $autosave
# 					if [ "$debug" = false ] ; then
# 						rm -Rfv $autosave
# 					fi

# done	
		

# for f in 	$(find $name -type f \
# 					\( 	\
# 						-and \! -ipath "*00_Docs*" \
# 						-and \! -ipath "*01_Projects*" \
# 						-and \! -ipath "*_Finals*" \
# 				 	\) \
# #						-and \! -iname "*.txt" \
# #						-and \! -iname "*.prproj" \
# #						-and \! -iname "*.aep" \				
# #						-or -ipath "*02_Footage*" \
# #						-or -ipath "*03_Artwork*" \
# #						-or -ipath "*04_Restored*" \
# #						-or -ipath "*06_Grading*" \

# 				); do
						
# 				echo $f
# 				if [ "$debug" = false ] ; then
# 					rm -Rfv $f
# 				fi
				
# done
	
		
# IFS=$'\n'
# 	for fin in 	$(find $name -type f \(	-and -iname "*.mov" -or -iname "*.mxf"	\
# 									-and \! -iname "._*"					\) 
# 				); do 
	
# 		ffmpeg -y -i "$fin" -c:v libx264 -b:v 1500k -c:a aac -b:a 96k \
# 		-pix_fmt yuv420p -profile:v main -level 3.1 -f mp4 $fin-ref.mp4 ;
	
# 		echo "$fin"
# 		if [ "$debug" = false ] ; then
# 			rm -f "$fin"
# 		fi

# done
	
# 	for rename in $(find $name -name "*.mov-*"); do
		
# 		echo $rename
# 		if [ "$debug" = false ] ; then
# 				mv "${rename}" ${rename/.mov/}
# 		fi
						
# done
		
# 	for d in $(find $name -type d -empty); do		
			
# 			echo $d
# 			if [ "$debug" = false ] ; then
# 				rmdir -p $d	
# 			fi

# done


# }



# name=$1

# if [[ -n "$name" ]]; then
#     echo "$1"



# if [ -d "$name" ]; then
#   # Control will enter here if $DIRECTORY exists.
# 	echo "Is a folder"
	
# 	clean
	
	
# else
# 	echo "Not a folder"
# fi

# else
#     echo "argument error"
# fi

