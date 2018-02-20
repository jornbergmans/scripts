#!/bin/bash

ffmpeg -i /Volumes/FINALS/QUICKTIME\ FILES/LUKKIEN\ SHOWREELS/Lukkien-Showreel_jumbo_2015_HD_Deel-1.mp4 -vf scale=480:272 -framerate 24000/1001 -vcodec mpeg4 -b:v 1500k -acodec libmp3lame -b:a 64k -sample_rate 44100 -f avi /Volumes/FINALS/QUICKTIME\ FILES/LUKKIEN\ SHOWREELS/Lukkien-Showreel_jumbo_2015_HD_Deel-1.avi
