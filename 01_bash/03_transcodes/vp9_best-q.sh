ffmpeg -i "$1" -c:v libvpx-vp9 -pass 1 -b:v 250k -threads 1 -speed 4 \
  -tile-columns 0 -frame-parallel 0 \
  -g 100 -aq-mode 0 -an -f webm /dev/null

ffmpeg -i "$1" -c:v libvpx-vp9 -pass 2 -b:v 250k -threads 1 -speed 0 \
  -tile-columns 0 -frame-parallel 0 -auto-alt-ref 1 -lag-in-frames 25 \
  -g 100 -aq-mode 0 -c:a libopus -b:a 64k -f webm $1-vp9.webm