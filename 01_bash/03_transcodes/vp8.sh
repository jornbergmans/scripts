#/bin/bash/

IFS=$'\n'

sourcedir=$1
targetdir=$2
TODAY=$(date "+%d-%m-%Y");
basedir=$(basename "$sourcedir")

for i in $(find $sourcedir -and -not -iname ".*" -and -iname "*.mov" -or -iname "*.mp4"); do

basevp=$(basename "$i")

mkdir -p "$sourcedir/webm/"

		ffmpeg -y -i "$i" \
							-c:v libvpx -b:v 450k -threads 1 -speed 0 \
							-c:a libvorbis -b:a 96k \
							-vf scale=w=640:h=360:force_original_aspect_ratio=decrease -qmin 0 -qmax 42 \
							-auto-alt-ref 0 -lag-in-frames 0 -arnr-type backward \
							-keyint_min 1 -f webm "$sourcedir/webm/$basevp-vp8-360p-$TODAY.webm"
		
done

for name in $(find $sourcedir/webm -name "*.mov-vp8*.webm"); do
	mv "${name}" ${name/.mov-vp8/-vp8}
	echo "$name"
done

# biglist=$(find $sourcedir/webm -type f -and -iname "*480*.webm" -and -not -iname ".*")
# smalllist=$(find $sourcedir/webm -type f -and -iname "*272*.webm" -and -not -iname ".*")

       #  		for bigfiles in $biglist; do
	      #   		echo "Adding $bigfiles to zip file."
	      #   		zip -q -j1 $2/$basedir-480p.zip $bigfiles \;
	    		# done
        		
       #  		for smallfiles in $smalllist; do
	      #   		echo "Adding $smallfiles to zip file."
	      #   		zip -q -j1 $2/$basedir-272p.zip $smallfiles \;
	    		# done

#	  -force_key_frames 00:00:00.00,00:00:04.24,00:00:09.24,00:00:14.24,00:00:19.24,00:00:24.24,00:00:29.24,00:00:34.24,00:00:39.24,00:00:44.24,00:00:49.24,00:00:54.24,00:00:59.19 \