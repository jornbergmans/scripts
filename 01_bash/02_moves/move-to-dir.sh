	#!/bin/bash

IFS=$'\n'

proxydir=$1
n=$2

#echo $movedir 

for 	videos in $(find $proxydir -type f -iname "?00$n*"); do


basedir=$(find $proxydir -type d -and -ipath "*?00$n*" -and -iname "*Clip")

#		echo $videos
#		echo $basedir
		mv -v $videos $basedir
done