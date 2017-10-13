#/bin/bash

IFS=$'\n'

for f in $(find $1 -type f -iname "*.mov"); do

	ffmpeg -ss 00:01.000 -y -i "$f" -c:v copy -c:a copy -f mov $f-rewrap.mov ;

done
		
for name in $(find $1 -type f -iname "*-rewrap*"); do
	
	mv "${name}" ${name/.mov-rewrap/-rewrap}
	echo "$name"
		
done