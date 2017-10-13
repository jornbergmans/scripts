	#!/bin/bash

IFS=$'\n'

function clean {

# #cd */*ARCHIVED &&

echo "Cleaning"

for meta in $(find $name -type f \
				\( 	\
					-and -iname "._*" \
					-and -iname ".DS*" \
					-and -iname ".afpDel*" \
				\) \
			 ); do
				
		     echo $meta
		     if [ "$debug" = false ] ; then
			 	rm -fv $meta
			 fi
		
done


for autosave in $(find $name -type d \
					\(	\
					-and -iname "*Adobe Premiere Pro Auto-Save*" \
					-and -iname "*Adobe Premiere Pro Video Previews" \
					\) \
				 ); do
					
					
					echo $autosave
					if [ "$debug" = false ] ; then
						rm -Rfv $autosave
					fi

done	
		

for f in 	$(find $name -type f \
					\( 	\
						-and \! -ipath "*00_Docs*" \
						-and \! -ipath "*01_Projects*" \
						-and \! -ipath "*_Finals*" \
				 	\) \
#						-and \! -iname "*.txt" \
#						-and \! -iname "*.prproj" \
#						-and \! -iname "*.aep" \				
#						-or -ipath "*02_Footage*" \
#						-or -ipath "*03_Artwork*" \
#						-or -ipath "*04_Restored*" \
#						-or -ipath "*06_Grading*" \

				); do
						
				echo $f
				if [ "$debug" = false ] ; then
					rm -fv $f
				fi
				
done
	
		
IFS=$'\n'
	for fin in 	$(find $name -type f \(	-and -iname "*.mov" -or -iname "*.mxf"	\
									-and \! -iname "._*" 						\) 
				); do 

		echo "$fin"
		
		if [ "$debug" = false ] ; then

		ffmpeg -y -i "$fin" -c:v libx264 -b:v 1500k -c:a aac -b:a 96k \
		-pix_fmt yuv420p -profile:v main -level 3.1 -f mp4 $fin-ref.mp4 ;
	
			rm -fv "$fin"
		fi

done
	
	for rename in $(find $name -name "*.mov-ref*"); do
		
		# echo $rename
		if [ "$debug" = false ] ; then
				mv "${rename}" ${rename/.mov/}
		fi
						
done
		
	for d in $(find $name -type d -empty); do		
			
			# echo $d
			if [ "$debug" = false ] ; then
				rmdir -p $d	
			fi

done

}



# Example
# find_and_delete_2016_02.sh /Volumes/ALPHA/02_ARCHIVE/ALPHA\ ARCHIVED/ false
# find_and_delete_2016_02.sh /Volumes/ALPHA/02_ARCHIVE/ALPHA\ ARCHIVED/ true

debug=$2

if [[ -n "$debug" ]]; then
	debug=$2
else	
	#echo 'debug mode'
	debug=true
fi

name=$1

if [ "$debug" = false ] ; then
    echo 'debug mode off!'
else 
	echo 'debug mode'
fi 

#echo $debug

if [[ -n "$name" ]]; then
	echo "$1"

	if [[ "$name" = */*ARCHIVED/* ]]; then 
		echo "Archive check passed"


		if [ -d "$name" ]; then
			echo "Folder check passed"

			clean

		else
			echo "Folder check failed"
		fi

	else
		echo "argument error Archive check failed"
	fi

else 
	echo "argument error no input"
fi
