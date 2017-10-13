#/bin/bash/

IFS=$'\n'

sourcedir=$1
targetdir=$2
TODAY=$(date "+%d-%m-%Y");
basedir=$(basename "$sourcedir")

for i in $(find $sourcedir -and -not -iname ".*" -and -iname "*.mov" -or -iname "*.mp4"); do

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

for name in $(find $sourcedir/webm -name "*.mov-vp8*.webm"); do
	mv "${name}" ${name/.mov-vp8/-vp8}
	echo "$name"
done

biglist=$(find $sourcedir/webm -type f -and -iname "*480*.webm" -and -not -iname ".*")
smalllist=$(find $sourcedir/webm -type f -and -iname "*272*.webm" -and -not -iname ".*")

        		for bigfiles in $biglist; do
	        		echo "Adding $bigfiles to zip file."
	        		zip -q -j1 $2/$basedir-480p.zip $bigfiles \;
	    		done
        		
        		for smallfiles in $smalllist; do
	        		echo "Adding $smallfiles to zip file."
	        		zip -q -j1 $2/$basedir-272p.zip $smallfiles \;
	    		done


#mkdir -p "$sourcedir/h264/"
#
#		ffmpeg -y -i "$i" 	-c:v libx264 -b:v 1200k \
#							-c:a aac -b:a 96k \
#							-vf scale=w=480:h=272:force_original_aspect_ratio=decrease -qmin 0 -qmax 42 \
#							-profile:v main -level 3.1 -pix_fmt yuv420p \
#							-keyint_min 1 -f mp4 "$sourcedir/h264/$basevp-h264-272p.mp4"
#
#		ffmpeg -y -i "$i" 	-c:v libx264 -b:v 1500k \
#							-c:a aac -b:a 96k \
#							-vf scale=w=800:h=480:force_original_aspect_ratio=decrease -qmin 0 -qmax 42 \
#							-profile:v main -level 3.1 -pix_fmt yuv420p \
#							-keyint_min 1 -f mp4 "$sourcedir/h264/$basevp-h264-480p.mp4"
#		
#done
#
#for name in $(find $sourcedir/h264/ -name "*.mov-h264*.mp4"); do
#	mv "${name}" ${name/.mov-h264/-h264}
#	echo "$name"
#		
#done
#
#	  -force_key_frames 00:00:00.00,00:00:04.24,00:00:09.24,00:00:14.24,00:00:19.24,00:00:24.24,00:00:29.24,00:00:34.24,00:00:39.24,00:00:44.24,00:00:49.24,00:00:54.24,00:00:59.19 \
#
# for moveitem in $(find $sourcedir -and -iname "*.webm" -and \! -iname "._"); do
# 	cp $moveitem /Volumes/TRANSFER/transfer-accounts-AV/mediamanager/00_los/02_TomTom/TomTom_update-VIA53_new-features_16110108/20170406/
# done
