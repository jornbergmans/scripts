#/bin/bash

IFS=$'\n'


 for f in $(find . -type f -iname "*.mov"); do
 
 	echo "$f"
 	
	ffmpeg -y -i "$f"	 -c:v msmpeg4 -b:v 1000k -minrate 800k \
						-c:a libmp3lame -ar 48000 -b:a 128k \
						-g 25 -keyint_min 1 \
						$f.wmv 
						
	ffmpeg -y -i "$f"	 -c:v msmpeg4 -b:v 1000k -minrate 800k \
						-c:a libmp3lame -ar 48000 -b:a 128k \
						-g 25 -keyint_min 1 \
						-vf scale=-1:36 \
						$f-scaled.wmv								

	done
	
	mkdir wmv
	
 for name in $(find . -name "*mov.wmv" -or -name "*.mov-*"); do
		mv "${name}" "./wmv/${name/.mov/}"

done