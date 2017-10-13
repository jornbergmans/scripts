#/bin/bash

IFS=$'\n'

for f in $(find $1 -type f -iname "*$2"); do

	ffmpeg -ss 00:01.000 -y -i "$f" -c:v copy -c:a copy -f $2 $f-rewrap.$2 ;

done
		
for name in $(find $1 -type f -iname "*-rewrap*"); do
	
	mv "${name}" ${name/.$2-rewrap/-rewrap}
	echo "$name"
		
done
