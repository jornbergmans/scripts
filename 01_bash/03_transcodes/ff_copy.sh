#/bin/bash

IFS=$'\n'

	for 	f in $(find . -type f -iname "*.mp4"); do 
				ffmpeg 		-y -i "$f" -c:v copy -c:a copy \
				-f mov $f.mov ;
done
		
	for 	name in $(find . -name "*mp4.mov"); do
				mv "${name}" ${name/mp4.mov/mov}
	echo 	"$name"
done

mkdir -p ./mov/

	for m in $(find . -type f -iname "*.mov"); do
		mv "$m" ./mov/
done