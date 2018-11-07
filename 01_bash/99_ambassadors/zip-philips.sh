#!/bin/bash
IFS=$'\n'

zipdir="$1"
dest="$2"
sstring="$3"
debug="$4"

function makeref() {
  ffmpeg -hide_banner -loglevel panic -pattern_type glob \
  -y -i "$zipfolder/*.$sstring" -c:v libx264 -b:v 2500k \
  -pix_fmt yuv420p -r 25 -f mp4 "$output.mp4"
}

if [[ ! "$debug" = false ]] ; then
  echo ""
  echo "Debug mode on. Checking for folders to zip, please wait..."
  echo ""
fi

if [[ -z "$1" ]] && [[ -z "$2" ]] && [[ -z "$3" ]]; then
  echo "Variables not set. Please input"
  echo "1: Input folder"
  echo "2: Dest folder"
  echo "3: Search string"
  echo "4: Debug mode - input 'false' to run live mode"
else
  zipfolders=$(find "$zipdir" -depth -type d)

  for zipfolder in $zipfolders; do

    filelist=$(find "$zipfolder" -mindepth 1 -maxdepth 1 -type f -and -iname "*$sstring*" -and -not -iname ".*" -and -not -iname "*.zip")
    count=$(find "$zipfolder" -mindepth 1 -maxdepth 1 -type f -and -iname "*$sstring*" -and -not -iname ".*" -and -not -iname "*.zip" | wc -l)

    basedest=$(basename "$zipfolder")
    dirdest=$(dirname "$zipfolder")
    zipname=$(basename "$dirdest")
    output="$dest"/"$zipname"/360_"$zipname"_"$basedest"

    if [[ "$count" -gt 1 ]]; then
      if [[ ! "$debug" = false ]] ; then
        echo "basedest = $basedest"
        echo "dirdest = $dirdest"
        echo "zipname = $zipname"
        echo "full output path will be $output.zip"
        echo " "
        echo "Will archive $count files in $zipfolder that contain the string $sstring"
        echo "And create a reference file at $output.zip"
      else
        if [[ -f $output.zip ]]; then
        echo "Zip file $output.zip already exists, skipping."
        echo " "
        else
          mkdir -p "$dest"/"$zipname"/
          echo "Zipping $count files in $zipfolder, please wait..."
          zip -jq1 "$output".zip "$filelist" \;
          echo "Zip of $zipfolder completed!"
          echo "The file can be found at $output.zip"
          echo " "
        fi
        if [[ $sstring = png ]] || [[ $sstring = dpx ]] || [[ $sstring = exr ]] || [[ $sstring = tif* ]] || [[ $sstring = jp*g ]]; then
          if [[ ! -f $output.mp4 ]]; then
            echo "A reference file will be created at $output.mp4"
            echo " "
            makeref
          elif [[ -f $output.mp4 ]]; then
            echo "A reference file for this zip already existst."
            echo "Overwrite? y/n"
            select yn in "Yes" "No"; do
                case $yn in
                    Yes ) makeref; break;;
                    No ) echo "Not creating reference file" && exit;;
                esac
            done
          fi
        fi
      fi
    fi
  done
  echo " "
  echo "All done!"
fi
