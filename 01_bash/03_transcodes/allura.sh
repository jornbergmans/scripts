#/bin/bash/

IFS=$'\n'

base1=$(basename "$1")

for f in $(find "$1" -type f -iname "*.mov"); do

basef=$(basename "$f")

	if [ $3 == "live" ]; then
			ffmpeg -y -i $f \
				-c:v libx264 -b:v 40000k -c:a aac -b:a 256k \
				-pix_fmt yuv420p -profile:v main -level 5.1 \
				-filter_complex "colorspace=bt709:bt709:dither=none" \
			-f mp4 "$2/$basef-none-40.mp4"
	elif
		[ $3 == "prev" ]; then
			ffmpeg -y -i $f \
				-c:v libx264 -b:v 40000k -c:a aac -b:a 256k \
				-pix_fmt yuv420p -profile:v main -level 5.1 \
				-vf "scale=3840:4320, crop=3840:2160:0:0" \
			-f mp4 "$2/$basef-mono-prev.mp4"
	fi
done

for mov in $(find "$2" -type f -iname "*.mov-*.*"); do
		mv "${mov}" ${mov/.mov-/-}
done

		# -auto-alt-ref 0 -arnr-type backward \
		# -keyint_min 1 -force_key_frames "expr:gte(t,n_forced*1)" \
		# -filter_complex "boxblur=chroma_radius=3,colorspace=bt709:bt709:dither=fsb,deband=direction=2" \
