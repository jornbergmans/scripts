#/bin/bash

IFS=$'\n'

	for zips in $(find $1 -mindepth 1 -maxdepth 1 -type d -iname "*$2*"); do
	
	echo "$zips"
	zip -rv0 "$zips".zip $zips
	
		
done
