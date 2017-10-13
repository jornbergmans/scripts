#/bin/bash

IFS=$'\n'
PWD="`pwd`"

source=$1
dest=$2

debug=$3
if [[ -n "$debug" ]]; then
	debug=$3
else
	debug=true
fi

#zips=$(find $source -mindepth 1 -maxdepth 1 -type d)

function do_zip
{

for zips in 	$(find $source -mindepth 1 -maxdepth 1 -type d); do

basedir=$(echo $zips | sed 's:/Volumes/::')
basezips=$(basename "$zips")

#mkdir -p $dest/$basedir/

#	echo $dest/$source

	if [ $debug = true ] ; then
		echo $dest/$basedir/$basezips
	else
		mkdir -p $dest/$basedir/
		zip -rv0 $dest/$basedir/"$basezips".zip $zips
	fi

done
}

do_zip
