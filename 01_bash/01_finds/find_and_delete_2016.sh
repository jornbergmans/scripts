#!/bin/bash

IFS=$'\n'

function clean {

echo "Cleaning"

if [[ $debug = false ]] ; then
	for meta in $(find "$name" -type f \
					\( 	\
					-iname "._*" -and \
					-iname ".DS*" -and \
					-iname ".afpDel*" \
					\) \
			 	); do
				
			 	rm -f $meta
	done
fi

for autosave in $(find "$name" -type d \
					\(	\
					-iname "*01_Premiere/*Adobe Premiere Pro*" \
					\) \
				); do
					
					echo "Removing $autosave from project"
					if [ "$debug" = false ] ; then
						rm -Rf $autosave
					fi

done	

for zipfin in 	$(find "$name" -type f \	
					\(	\
						-ipath "*/04_Finals/*" 	\
						-iname "*.zip"		\
					\) \
				); do

				if [ "$debug" = false ] ; then
					unzip $zipfin
					rm -f $zipfin
				else
					echo "Unzip finals compressed to "$zipfin""
				fi
done

for f in 	$(find "$name" -type f \
					\( 	\
						-not -ipath "*00_Docs*" \
						-and -not -ipath "*01_Projects*" \
						-and -not -ipath "*_Finals*" \
				 	\) \
				); do
						
				echo "Removing $f from project"
				if [ "$debug" = false ] ; then
					rm -f $f
				fi
				
done
	
		
IFS=$'\n'
	for fin in 	$(find "$name" -type f \
					\(	-iname "*.mov" -or -iname "*.mxf"						\
										-and -not -iname "._*" 									\
										-and -not -ipath "*Adobe Premiere Pro Video Previews*"	\
					\) 
				); do 

		echo "Transcode of $fin to reference file"
		
		if [ "$debug" = false ] ; then

		ffmpeg -y -i "$fin" -c:v libx264 -b:v 1500k -c:a aac -strict 2 -b:a 96k \
		-pix_fmt yuv420p -profile:v main -level 3.1 -f mp4 $fin-ref.mp4 ;
	
			rm -fv "$fin"
		fi

done
	
	for rename in $(find "$name" -name "*.mov-ref*"); do
		
		# echo $rename
		if [ "$debug" = false ] ; then
				mv "${rename}" ${rename/.mov/}
		fi
						
done
		
	for d in $(find "$name" -type d -empty); do		
			
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
	echo 'running in debug mode.'
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
