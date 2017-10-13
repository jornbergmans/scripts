#!/bin/bash

IFS=$'\n'

	for meta in $(find . -type f \
					\( 	\
						-and -iname "._*" \
						-and -iname ".DS*" \
						-and -iname ".afpDel*" \
				 	\) \
				 ); do
				 	
#				 	echo $meta
				 	rm -Rfv $meta
		
done

	for autosave in $(find . -type d \
					-iname "*Adobe Premiere Pro Auto-Save*" 
					 \
				 ); do

					rm -Rfv $autosave

done	
		
	for f in 	$(find . -type f \
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
						
#				echo $f
				rm -Rfv $f
				
done
	
		
IFS=$'\n'
	for fin in 	$(find . -type f \(	-and -iname "*.mov" -or -iname "*.mxf"	\
									-and \! -iname "._*"					\) 
				); do 
	
		ffmpeg -y -i "$fin" -c:v libx264 -b:v 1500k -c:a aac -b:a 96k \
		-pix_fmt yuv420p -profile:v main -level 3.1 -f mp4 $fin-ref.mp4 ;
	
		rm -f "$fin"

done
	
	for name in $(find . -name "*.mov-*"); do
	
		mv "${name}" ${name/.mov/}
						
done
		
	for d in $(find . -type d -empty); do		
	
			rmdir -p $d	

done
