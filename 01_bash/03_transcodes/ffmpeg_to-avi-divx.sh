INPUT="/Volumes/FINALS/MXF FILES/TEST/Aegis-Media_Regio-Bank-Weer_Billboard_Wordt.mov"
INPUT="/Volumes/FINALS/MXF FILES/TEST/bird.avi"

OUTPUT="/Volumes/FINALS/MXF FILES/TEST/Aegis-Media_Regio-Bank-Weer_Billboard_Wordt.avi"
OUTPUT="/Volumes/FINALS/MXF FILES/TEST/bird_groter.avi"

SETTING="-c:v mpeg4 -vtag xvid -b:v 4000k -acodec libmp3lame -b:a 192k -sample_rate 44100 -f avi"
SETTING="-vcodec mpeg4 -b:v 1500k -acodec libmp3lame -b:a 64k -sample_rate 44100 -f avi"
SETTING="-b:v 1500k -acodec libmp3lame -b:a 64k -sample_rate 44100 -f avi"
SETTING="-vcodec wmv1 -b:v 1500k -an -pix_fmt yuv410p -f avi"

ffmpeg -i "$INPUT" -vf scale=1024:576 $SETTING "$OUTPUT"

"/Volumes/FINALS/MXF FILES/Thu Feb  4 15-19-18 2016/bird.avi"