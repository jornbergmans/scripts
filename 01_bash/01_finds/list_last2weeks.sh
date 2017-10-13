#!/bin/bash

IFS=$'\n'
today=`date '+%d-%m-%Y'`;

date=$(date -v -2w "+%Y-%m-%d")
	echo $date

	for mxf in \
				$(find 		/Volumes/FINALS/MXF\ FILES/ -type f 		\
						\( 	-and -iname "*.mxf" -or -iname "*.mp4" 		\
							-and \! -iname "._*"					\)	\
							-newerct $date								\
				); do

	echo $mxf >> /Volumes/ELEMENTS/10_SCRIPTS/01_bash/99_output/last2_$today.txt

done

	for web in 	
				$(find 		/Volumes/FINALS/QUICKTIME\ FILES/ -type f	\
						\( 	-and -iname "*.mov" -or -iname "*.mp4" 		\
							-and \! -iname "._*"					\)	\
							-newerct $date								\
				); do

	echo $web >> /Volumes/ELEMENTS/10_SCRIPTS/01_bash/99_output/last2_$today.txt

done

open /Volumes/ELEMENTS/10_SCRIPTS/01_bash/99_output/last2_$today.txt



find /Volumes/FINALS/QUICKTIME\ FILES/ -type f \( -and -iname "*.mov" -or -iname "*.mp4" -and \! -iname "._*" \) -newerct