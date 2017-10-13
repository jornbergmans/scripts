#!/bin/bash

#############
# DEFINITIONS
#############

IFS=$'\n'
TODAY=$(date "+%d-%m-%Y");
DATE=$(date -v -2m "+%Y-%m-%d")

# basetv=$(basename "$tv")
# baseweb=$(basename "$web")

	mkdir -p /Volumes/ELEMENTS/10_SCRIPTS/99_output/2mnt/mxf/$TODAY/
    mkdir -p /Volumes/ELEMENTS/10_SCRIPTS/99_output/2mnt/web/$TODAY/

# echo $date

# ##############################
# # FIND EN ENCODE TV LEVERINGEN
# ##############################

for tv in \
				$(find 		$1 -type f 				\
						\( 	-iname "*.mxf"  	\)	\
							-newermt $DATE			\
				); do

basetv=$(basename "$tv")

	ffmpeg 				-y -i "$tv" -c:v libx264 -b:v 1500k -c:a aac -b:a 96k \
						-pix_fmt yuv420p -profile:v main -level 3.1 -f mp4 \
						/Volumes/ELEMENTS/10_SCRIPTS/99_output/2mnt/mxf/$TODAY/$basetv-ref-tv.mp4 ;
done

# find 			/Volumes/FINALS/MXF\ FILES/ -type f -iname "*-ref-tv.mp4" \
# 				-exec mv {} /Volumes/ELEMENTS/10_SCRIPTS/99_output/2mnt/mxf/ \;
# done		

# # ###############################
# # # FIND EN ENCODE WEB LEVERINGEN
# # ###############################

for web in 	\
				$(find 		$2 -type f	\
						\( 	-and -iname "*.mov" -or -iname "*.mp4" 	\)	\
							-newermt $DATE								\
				); do

baseweb=$(basename "$web")

	ffmpeg 				-n -i "$web" -c:v libx264 -b:v 1500k -c:a aac -b:a 96k \
						-pix_fmt yuv420p -profile:v main -level 3.1 -f mp4 \
						/Volumes/ELEMENTS/10_SCRIPTS/99_output/2mnt/web/$TODAY/$baseweb-ref-web.mp4 ;
done

# find 			/Volumes/FINALS/QUICKTIME\ FILES/ -type f -iname "*-ref-web.mp4" \
# 				-exec mv {} /Volumes/ELEMENTS/10_SCRIPTS/99_output/2mnt/web/ \;
# done
	
# #######################
# # RENAME JOBS VOOR REFS
# #######################
	
	for name in \
				$(find 	/Volumes/ELEMENTS/10_SCRIPTS/99_output/2mnt/ -name "*.mxf-ref*"); do
	mv			"${name}" ${name/.mxf/}
					
done

	
	for name in \
				$(find 	/Volumes/ELEMENTS/10_SCRIPTS/99_output/2mnt/ -and -iname "*.mp4-ref*" -or -iname "*.mov-ref*" ); do
	mv			"${name}" ${name/.mp4/}
					
done

# mv "/Volumes/ELEMENTS/10_SCRIPTS/99_output/2mnt/" "$3"