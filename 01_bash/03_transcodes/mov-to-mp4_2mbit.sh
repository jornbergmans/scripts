#/bin/bash

IFS=$'\n'
	for f in $(find . -type f -iname "*.mov"); do 
		
		ffmpeg -y -i "$f" -c:v libx264 -b:v 2000k -c:a libfdk_aac -b:a 96k \
		-pix_fmt yuv420p -profile:v main -level 3.1 -f mp4 $f-ref.mp4 ;

done
		
	for name in $(find . -name "*mov.mp4"); do
	mv "${name}" ${name/mov.mp4/mp4}
	echo "$name"
		
done

	for m in $(find . -type f -iname "*.mov"); do
		rm -fv "$m"

done