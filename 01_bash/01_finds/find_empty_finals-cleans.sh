#/bin/bash

IFS=$'\n'
today=`date '+%d-%m-%Y'`;

targetdir=$1

# server='find . -type d -ipath "/Volumes/*/01_*/"'
PWD="`pwd`"

mkdir -p /Volumes/ELEMENTS/10_SCRIPTS/99_output/empty_finals/$today/

function empties {

echo Searching $PWD

	find .				-type f 			\( -ipath "*02_*TO\ ARCH*render*" -and -ipath "*final*" -or -ipath "*clean*" -and \! -ipath "*audio*"		\)	\(	-and -iname ".*" \) -exec rm -f {} 	 \;

echo "-- SERVER NAME --"						>> /Volumes/ELEMENTS/10_SCRIPTS/99_output/empty_finals/$today/empty_finals_$today.txt
	echo $PWD									>> /Volumes/ELEMENTS/10_SCRIPTS/99_output/empty_finals/$today/empty_finals_$today.txt
echo " " 										>> /Volumes/ELEMENTS/10_SCRIPTS/99_output/empty_finals/$today/empty_finals_$today.txt
	find .				-type d 			\( -and -ipath "*02_*TO\ ARCH*render*" -and -iname "*final*" 	-and \! -ipath "*restore*" 	\) -empty 		>> /Volumes/ELEMENTS/10_SCRIPTS/99_output/empty_finals/$today/empty_finals_$today.txt
echo " "										>> /Volumes/ELEMENTS/10_SCRIPTS/99_output/empty_finals/$today/empty_finals_$today.txt
echo "-- END -- "								>> /Volumes/ELEMENTS/10_SCRIPTS/99_output/empty_finals/$today/empty_finals_$today.txt


echo "-- SERVER NAME --"						>> /Volumes/ELEMENTS/10_SCRIPTS/99_output/empty_finals/$today/empty_cleans_$today.txt
	echo $PWD									>> /Volumes/ELEMENTS/10_SCRIPTS/99_output/empty_finals/$today/empty_cleans_$today.txt
echo " " 										>> /Volumes/ELEMENTS/10_SCRIPTS/99_output/empty_finals/$today/empty_cleans_$today.txt
	find .				-type d 			\( -and -ipath "*02_*TO\ ARCH*render*" -and -iname "*clean*" 	-and \! -ipath "*restore*" 	\) -empty 		>> /Volumes/ELEMENTS/10_SCRIPTS/99_output/empty_finals/$today/empty_cleans_$today.txt
echo " "										>> /Volumes/ELEMENTS/10_SCRIPTS/99_output/empty_finals/$today/empty_cleans_$today.txt
echo "-- END -- "								>> /Volumes/ELEMENTS/10_SCRIPTS/99_output/empty_finals/$today/empty_cleans_$today.txt
}

if [ -z ${targetdir} ]; then
	cd /Volumes/ALPHA/
		empties
	cd /Volumes/BETA/
		empties
	cd /Volumes/DELTA/
		empties
	cd /Volumes/PHILIPS/
		empties
	cd /Volumes/TOMTOM/
		empties
	cd /Volumes/RTL/
		empties
	cd ~/
else
	cd $targetdir
		empties
	cd ~/
fi
