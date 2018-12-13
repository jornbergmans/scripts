#!/usr/bin/env bash
#Purpose = to mux video and audio
#Created on 13-11-2017
#Modified on 08-08-2018
#Author = Berry van Voorst
Version="Mux MP4 v0.9.2 / cmd alias: mux4"

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
Colour='\033[0;35m'
# Cyan='\033[0;36m'
NC='\033[0m' # No Color
echo "---------------------------------------------------"
echo -e "${Colour}This script($Version) combines a video file and an audio file to an MP4 file.${NC}"
echo "to stop the script use 'crtl + z'"
echo "---------------------------------------------------"

date=$(date +%Y%m%d)
time=$(date +%H%M)
defaultpath="/Volumes/Media2/EPISODE_OUT"

read -p 'Enter name of movie(drag the movie into the cmd window): ' input
echo "For which purpose is the MP4?"
select choice_bitrate in "Cube-preview" "YouTube_etc" "Custom-settings"; do
  case $choice_bitrate in
      Cube-preview ) answer_bitrate="1"; break;;
      YouTube_etc ) answer_bitrate="2"; break;;
      Custom-settings ) answer_bitrate=""; break;;
      *) echo This is not a valid option. Please try again.;;
    esac
  done
if [ "$answer_bitrate" = "1" ]; then
    bitrate=10000
    minbitrate=8000
    maxbitrate=12000
elif [ "$answer_bitrate" = "2" ]; then
    bitrate="18000"
    minbitrate="16000"
    maxbitrate="20000"
else
read -p 'Enter avg bitrate per sec in kilobits(example 16Mbps = 16000k, enter: 16000): ' bitrate
read -p 'Enter min bitrate per sec in kilobits(example 12Mbps = 12000k, enter: 12000): ' minbitrate
read -p 'Enter max bitrate per sec in kilobits(example 20Mbps = 20000k, enter: 20000): ' maxbitrate
fi

framerate=$(ffprobe -v error -select_streams v:0 -show_entries stream=avg_frame_rate -of default=noprint_wrappers=1:nokey=1 "$input")
#framerate=$(ffprobe -v error -count_frames -select_streams v:0 -show_entries stream=nb_read_frames -of default=noprint_wrappers=1:nokey=1 "$input")

echo "Audio?(enter a number, 'no' result in a MUTE file)"
select askforaudio in "yes" "no"; do
  case $askforaudio in
      yes ) answeraudio="yes"; break;;
      no ) answeraudio="no"; break;;
      *) echo This is not a valid option. Please try again.;;
    esac
  done

if [ "$answeraudio" != "no" ]; then
read -p 'Enter name of audio track(drag audio file into the cmd window): ' inputaudio
ffmpeg -hide_banner -nostats -i "${inputaudio}" -filter_complex ebur128 -f null -

durvideo=$(ffprobe -v error -show_entries format=duration -of default=noprint_wrappers=1:nokey=1 -sexagesimal "$input")
duraudio=$(ffprobe -v error -show_entries format=duration -of default=noprint_wrappers=1:nokey=1 -sexagesimal "$inputaudio")
if [[ "$duraudio" = "$durvideo" ]]; then
  read -e -i "$defaultpath" -p 'Enter path for output folder(drag output folder into the cmd window): ' otherpath
  path="${otherpath:-$defaultpath}"
  inputoutput=$(basename "$input")
  inputoutput2="${inputoutput%.*}"
  read -e -i "$inputoutput2"_$date-$time.mp4 -p 'Enter output name: ' outputname
  output="${outputname:-$inputoutput2}"
ffmpeg -hide_banner -loglevel warning -i "${input}" -i "$inputaudio" -map 0:v -map 1:a -c:v libx264 -x264-params keyint=25 -b:v "$bitrate"k -minrate "$minbitrate"k -maxrate "$maxbitrate"k -bufsize "$maxbitrate"k -pix_fmt yuv420p -profile:v high -level 42 -vf "scale=trunc(iw/2)*2:trunc(ih/2)*2" -x264opts colorprim=bt709:transfer=bt709:colormatrix=bt709 -c:a aac -b:a 320k -f mp4 -y $path/"${output}"
else
  fout="!!! Audio file duration of $duraudio does not match Video file duration of $durvideo !!!"
  osascript -e 'tell app "System Events" to display dialog "'"${fout}"'" buttons {"Cancel", "Continue"}' >/dev/null 2>&1

######## Encoding with no matching duration of video and audio files
if [ $? -eq 0 ]; then
  read -e -i "$defaultpath" -p 'Enter path for output folder(drag output folder into the cmd window): ' otherpath
  path="${otherpath:-$defaultpath}"
  inputoutput=$(basename "$input")
  inputoutput2="${inputoutput%.*}"
  read -e -i "$inputoutput2"_$date-$time.mp4 -p 'Enter output name: ' outputname
  output="${outputname:-$inputoutput}"
  ffmpeg -hide_banner -loglevel warning -i "${input}" -i "$inputaudio" -map 0:v -map 1:a -c:v libx264 -x264-params keyint=25 -b:v "$bitrate"k -minrate "$minbitrate"k -maxrate "$maxbitrate"k -bufsize "$maxbitrate"k -pix_fmt yuv420p -profile:v high -level 42 -vf "scale=trunc(iw/2)*2:trunc(ih/2)*2" -x264opts colorprim=bt709:transfer=bt709:colormatrix=bt709 -c:a aac -b:a 320k -f mp4 -y $path/"${output}"
else
  exit 1
fi
fi

if [ "$?" != "0" ]; then
  osascript -e 'set alertResult to display alert "Error occured!" buttons {"OK"} as warning'
  exit 1
  fi

echo "ffmpeg info: bash script mux_video-audio_to_MP4.sh (${Version})

/usr/local/bin/ffmpeg -hide_banner -loglevel warning -i ${input} -i $inputaudio -map 0:v -map 1:a -c:v libx264 -x264-params keyint=25 -b:v $bitrate k -minrate $minbitrate k -maxrate $maxbitrate k -bufsize $maxbitrate k -pix_fmt yuv420p -profile:v high -level 42 -vf scale=trunc(iw/2)*2:trunc(ih/2)*2 -x264opts colorprim=bt709:transfer=bt709:colormatrix=bt709 -c:a aac -b:a 320k -f mp4 -y $path/${output}

-VIDEO INPUT: ${input}
-AUDIO INPUT: ${inputaudio}
-FRAME RATE: ${framerate}
-BITRATE VIDEO: -avgrate ${bitrate}k -minrate ${minbitrate}k -maxrate ${maxbitrate}k -bufsize ${maxbitrate}k
-BITRATE AUDIO: 320k
-OUTPUT FILE: $path/${output}" >> $path/"${output}.log"

  osascript -e 'set alertResult to display alert "All files converted with ffmpeg converter!" buttons {"OK"} as warning'
  exit 1
fi

######## Encoding without audio
read -e -i "$defaultpath" -p 'Enter path for output folder(drag output folder into the cmd window): ' otherpath
path="${otherpath:-$defaultpath}"
inputoutput=$(basename "$input")
inputoutput2="${inputoutput%.*}"
read -e -i "$inputoutput2"_$date-$time.mp4 -p 'Enter output name: ' outputname
output="${outputname:-$inputoutput}"
ffmpeg -hide_banner -loglevel warning -i "$input" -an -c:v libx264 -x264-params keyint=25 -b:v "$bitrate"k -minrate "$minbitrate"k -maxrate "$maxbitrate"k -bufsize "$maxbitrate"k -pix_fmt yuv420p -profile:v high -level 42 -vf "scale=trunc(iw/2)*2:trunc(ih/2)*2" -x264opts colorprim=bt709:transfer=bt709:colormatrix=bt709 -f mp4 -y "$path/${output}"

if [[ "$?" != "0" ]]; then
  osascript -e 'set alertResult to display alert "Error occured!" buttons {"OK"} as warning'
  exit 1
  fi

  echo "ffmpeg info: bash script mux_video-audio_to_MP4.sh (${Version})

  /usr/local/bin/ffmpeg -hide_banner -loglevel warning -i $input -an -c:v libx264 -x264-params keyint=25 -b:v $bitrate k -minrate $minbitrate k -maxrate $maxbitrate k -bufsize $maxbitrate k -pix_fmt yuv420p -profile:v high -level 42 -vf scale=trunc(iw/2)*2:trunc(ih/2)*2 -x264opts colorprim=bt709:transfer=bt709:colormatrix=bt709 -f mp4 -y $path/${output}

  -VIDEO INPUT: ${input}
  -AUDIO INPUT: NO AUDIO
  -FRAME RATE: ${framerate}
  -BITRATE VIDEO: -avgrate ${bitrate}k -minrate ${minbitrate}k -maxrate ${maxbitrate}k -bufsize ${maxbitrate}k
  -OUTPUT FILE: $path/${output}" >> $path/"${output}.log"

  osascript -e 'set alertResult to display alert "All files converted with ffmpeg converter!" buttons {"OK"} as warning'
  exit 1
