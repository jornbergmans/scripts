#/bin/bash

IFS=$'\n'

	for ss_avi in $(find . -type f -iname "*.avi"); do 
		
		ffmpeg -y -i "$ss_avi" -c:v libx264 -c:a libfdk_aac \
		-pix_fmt yuv420p -profile:v main -level 3.1 -f mp4 $ss_avi.mp4 ;

 

done
		
	for name in $(find . -name "*avi.mp4"); do
	mv "${name}" ${name/avi.mp4/mp4}
	echo "$name"
		
done