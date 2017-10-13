#/bin/bash

IFS=$'\n'

	for x in $(find . -type x -iname ""); do
	
	echo "$x"
		
done