#!/bin/bash

IFS=$'\n'
today=`date '+%d-%m-%Y'`;

input=$1
inname=$2
outname=$3

for folder in $(find $input -mindepth 1 -type d -iname '*$inname'); do
	echo "$folder"
	mv "$folder" "$(echo $folder | sed s/$inname/$outname/)"
done

for file in $(find $input -d -type f -iname '*$inname*'); do
	echo	mv "$file" "$(echo $file | sed s/$inname/$outname/)"
done