#!/usr/bin/env bash
# #!/usr/local/bin/bash
#Purpose = to mux video and audio
#Created on 29-12-2017
#Modified on 06-08-2018
#Author = Berry van Voorst
Version="Mux v0.8.4 / cmd alias: mux"

command -v ffmpeg &> /dev/null
if [ $? -eq 1 ]; then
osascript -e 'set alertResult to display alert "FFmpeg NOT installed! Download latest version from https://evermeet.cx/ffmpeg/ or http://www.ffmpegmac.net/ " buttons {"OK"} as warning'
exit 1
fi

if ((BASH_VERSINFO[0] < 4))
then
  echo "Sorry, you need at least bash-4 to run this script."
  echo "You have bash version: " $BASH_VERSION
  exit 1
fi
# Colour='\033[0;35m'
Cyan='\033[0;36m'
NC='\033[0m' # No Color
echo "---------------------------------------------------"
echo -e "${Cyan}This script($Version) combines a video file and an audio file.${NC}"
echo "to stop the script use 'crtl + z'"
echo "---------------------------------------------------"

date=$(date +%Y%m%d)
time=$(date +%H%M)
defaultpath="/Volumes/Media2/EPISODE_OUT"

read -p 'Enter name of movie(drag the movie into the cmd window): ' input
# read -p 'Enter video resolution(for example 1920x1080): ' size
# read -p 'Enter framerate(Fps for example 23.976 or 24 or 25 or 29.97 or 30): ' framerate
# read -p 'Enter profile level(example 3.1 or 4.1 or 5.1): ' level
# read -p 'Enter bitrate per sec: ' bitrate
# read -p 'Enter path for output folder: ' path
# inputoutput=$(basename "$input")
# read -e -i $inputoutput -p 'Enter output name: ' outputname
# output="${outputname:-$inputoutput}"

framerate=$(ffprobe -v error -select_streams v:0 -show_entries stream=avg_frame_rate -of default=noprint_wrappers=1:nokey=1 "$input")

echo "Audio?(enter a number 1 or 2, 'no' result in a MUTE file)"
select askforaudio in "yes" "no"; do
     case $askforaudio in
         yes ) answeraudio="yes"; break;;
         no ) answeraudio="no"; break;;
 	*) echo This is not a valid option. Please try again.;;
    esac
 done

if [ "$answeraudio" != "no" ]; then
read -p 'Enter name of audio track(drag audio file into the cmd window): ' inputaudio
# ffmpeg -hide_banner -nostats -i "${inputaudio}" -filter_complex ebur128 -f null /dev/null 2>&1 | grep 'I:'
# ffmpeg -hide_banner -nostats -i "${inputaudio}" -filter_complex ebur128 -f null - > "Lufsinfo.txt" | grep 'I:'
ffmpeg -hide_banner -nostats -i "$inputaudio" -filter_complex ebur128 -f null -
# ffprobe -f lavfi amovie="$inputaudio",ebur128=metadata=1 -show_frames -show_format /dev/null 2>&1 | grep 'I:'
durvideo=$(ffprobe -v error -show_entries format=duration -of default=noprint_wrappers=1:nokey=1 -sexagesimal "$input")
duraudio=$(ffprobe -v error -show_entries format=duration -of default=noprint_wrappers=1:nokey=1 -sexagesimal "$inputaudio")
if [[ "$duraudio" = "$durvideo" ]]; then
  read -e -i "$defaultpath" -p 'Enter path for output folder(drag output folder into the cmd window): ' otherpath
  path="${otherpath:-$defaultpath}"
  inputoutput=$(basename "$input")
  inputoutput2="${inputoutput%.*}"
  read -e -i "$inputoutput2"_$date-$time.mov -p 'Enter output name: ' outputname
  output="${outputname:-$inputoutput}"
  ffmpeg -hide_banner -loglevel warning -i "$input" -i "$inputaudio" -map 0:v -map 1:a -c copy -y "$path/${output}"
else
  ## echo -e "${Colour}!!!Audio file duration of $duraudio does not match Video file duration of $durvideo!!!${NC}"
  ## exit 1
  fout="!!! Audio file duration of $duraudio does not match Video file duration of $durvideo !!!"
  osascript -e 'tell app "System Events" to display dialog "'"${fout}"'" buttons {"Cancel", "Continue"}' >/dev/null 2>&1
  if [ $? -eq 0 ]; then
    read -e -i "$defaultpath" -p 'Enter path for output folder(drag output folder into the cmd window): ' otherpath
    path="${otherpath:-$defaultpath}"
    inputoutput=$(basename "$input")
    inputoutput2="${inputoutput%.*}"
    read -e -i "$inputoutput2"_$date-$time.mov -p 'Enter output name: ' outputname
    output="${outputname:-$inputoutput}"
    ffmpeg -hide_banner -loglevel warning -i "$input" -i "$inputaudio" -map 0:v -map 1:a -c copy -y "$path/${output}"
    else
    exit 1
    fi
fi

if [[ "$?" != "0" ]]; then
  osascript -e 'set alertResult to display alert "Error occured!" buttons {"OK"} as warning'
  exit 1
  fi

  echo "ffmpeg info: bash script mux_video-audio.sh (${Version})

  /usr/local/bin/ffmpeg -hide_banner -loglevel warning -i $input -i $inputaudio -map 0:v -map 1:a -c copy -y $path/${output}

  -VIDEO INPUT: ${input}
  -AUDIO INPUT: ${inputaudio}
  -FRAME RATE: ${framerate}
  -OUTPUT FILE: $path/${output}" >> $path/"${output}.log"

  osascript -e 'set alertResult to display alert "All files converted with ffmpeg converter!" buttons {"OK"} as warning'
  exit 1
fi

read -e -i "$defaultpath" -p 'Enter path for output folder(drag output folder into the cmd window): ' otherpath
path="${otherpath:-$defaultpath}"
inputoutput=$(basename "$input")
inputoutput2="${inputoutput%.*}"
read -e -i "$inputoutput2"_$date-$time.mov -p 'Enter output name: ' outputname
output="${outputname:-$inputoutput}"
ffmpeg -hide_banner -loglevel warning -i "$input" -an -c:v copy -y "$path/${output}"

if [[ "$?" != "0" ]]; then
  osascript -e 'set alertResult to display alert "Error occured!" buttons {"OK"} as warning'
  exit 1
fi

echo "ffmpeg info: bash script mux_video-audio.sh (${Version})

/usr/local/bin/ffmpeg -hide_banner -loglevel warning -i $input -an -c:v copy -y $path/${output}

-VIDEO INPUT: ${input}
-AUDIO INPUT: NO AUDIO
-FRAME RATE: ${framerate}
-OUTPUT FILE: $path/${output}" >> $path/"${output}.log"

  osascript -e 'set alertResult to display alert "All files converted with ffmpeg converter!" buttons {"OK"} as warning'
  exit 1
