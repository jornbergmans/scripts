#/bin/bash

IFS=$'\n'


for f in $(find "$1" -type f -iname "*.mov" -o -iname "*.mp4"); do

  basef=$(basename "$f")
	mkdir -p "$1/wmv"

 	echo "$f"

      ffmpeg  -y -i "$f" -pass 1 -passlogfile %~n1	\
              -c:v msmpeg4 -b:v 10000k -minrate 8000k \
              -threads 1 -keyint_min 1 -an \
              -f mpeg /dev/null \

      ffmpeg  -y -i "$f"	-pass 2 -passlogfile %~n1 \
              -c:v msmpeg4 -b:v 10000k -minrate 8000k \
  						-an -g 25 -keyint_min 1 \
              -vf "scale=4096:844" -qmin 1 -qmax 42 \
  						-y -f mpeg "$1/wmv/$basef-2pass-vbr.wmv" \

	done

 for name in $(find "$1/wmv" -iname "*mov*.wmv" -or -name "*.mp4*.wmv"); do
		mv "${name}" "${name/.mov/qt}"
    mv "${name}" "${name/.mp4/264}"

done

#  -c:a libmp3lame -ar 48000 -b:a 128k \
