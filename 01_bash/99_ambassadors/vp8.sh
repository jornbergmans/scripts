#!/bin/bash/

IFS=$'\n'

sourcedir=$1
targetdir=$2
TODAY=$(date "+%d-%m-%Y");
basedir=$(basename "$sourcedir")

searchlist=$(find $sourcedir -and -not -iname ".*" -and -iname "*.mov" -or -iname "*.mp4")

for i in $searchlist ; do
	basevp=$(basename "$i")
	mkdir -p "$sourcedir/webm/"

		# ffmpeg -y -i "$i" 	-c:v libvpx -pass 1 -b:v 1000k -threads 1 -speed 4 \
		# 					-tile-columns 0 -frame-parallel 0 \
		# 					-keyint_min 1 -an -f webm /dev/null

		ffmpeg -y -r 20 -i "$i" \
							-c:v libvpx -b:v 1200k -threads 1 -speed 0 \
							-c:a libvorbis -b:a 96k \
							-vf "scale=480:288,crop=480:272" -qmin 0 -qmax 42 \
							-auto-alt-ref 0 -lag-in-frames 0 -arnr-type backward \
							-keyint_min 1 -f webm "$sourcedir/webm/$basevp-vp8-272p-$TODAY.webm"

		ffmpeg -y -r 20 -i "$i" \
							-c:v libvpx -b:v 1200k -threads 1 -speed 0 \
							-c:a libvorbis -b:a 96k \
							-vf scale=w=800:h=480:force_original_aspect_ratio=decrease -qmin 0 -qmax 42 \
							-auto-alt-ref 0 -lag-in-frames 0 -arnr-type backward \
							-keyint_min 1 -f webm "$sourcedir/webm/$basevp-vp8-480p-$TODAY.webm"
done

sourcenames=$(find $sourcedir/webm -name "*.mov-vp8*.webm")
for name in $sourcenames; do
	mv "${name}" ${name/.mov-vp8/-vp8}
	echo "$name"
done

# biglist=$(find $sourcedir/webm -type f -and -iname "*480*.webm" -and -not -iname ".*")
# smalllist=$(find $sourcedir/webm -type f -and -iname "*272*.webm" -and -not -iname ".*")
#
#         		for bigfiles in $biglist; do
# 	        		echo "Adding $bigfiles to zip file."
# 	        		zip -q -j1 $2/$basedir-480p.zip $bigfiles \;
# 	    			done
#
#         		for smallfiles in $smalllist; do
# 	        		echo "Adding $smallfiles to zip file."
# 	        		zip -q -j1 $2/$basedir-272p.zip $smallfiles \;
# 	    			done
