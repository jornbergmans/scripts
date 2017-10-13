
#/bin/bash

IFS=$'\n'
#	for tomtom in $(find . -type f -iname "*.mov"); do 
#		
#		ffmpeg -y -i "$tomtom" -c:v libx264 -b:v 150000k -c:a libfdk_aac -b:a 192k \
#		-pix_fmt yuv420p -profile:v main -level 3.1 -f avi $tomtom.avi ;

 

#done
		
	for name in $(find . -name "*mov.avi"); do
	mv "${name}" ${name/mov.avi/avi}
	echo "$name"
		
done