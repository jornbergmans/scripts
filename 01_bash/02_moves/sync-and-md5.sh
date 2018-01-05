#!/usr/bin/env bash
IFS=$'\n'

datetime=$(date +%Y%m%d-%H%M)
## Check if any / enough arguments are supplied
if [[ -z "$1" ]]; then
  echo "No arguments supplied."
  exit 1
fi

if [[ ! "$#" -ge 2 ]]; then
  echo "Please supply both input folder and output folder(s),"
  echo "starting with the input folder as source of the original files,"
  echo "then output folder(s) as destination(s) for copies."
  exit 1
elif [[ "$#" -ge 2 ]]; then

  ## remove all leading and trailing whitespace from input folder
  ## and remove trailing slash ( / ) from input folder, so rsync will copy the whole folder, and not just its contents
  inFolder=$(echo "$1" | sed 's/^[ \t]*//;s/\/[ \t]*$//')

  ## Check whether the specified output directories exist
  ## If they don't, create them.
  if [[ ! -d "$2" ]]; then
    mkdir -p "$2"
  fi
    base2=$(basename "$2")

  if [[ -n "$3" ]] || [[ ! -d "$3" ]]; then
    mkdir -p "$3"
  fi
    base3=$(basename "$3")

  ## Start the data transfer using rsync.
  ## Let us know what you're doing, and log it
  rsync -ahv --log-file="$2/$base2-$datetime.log" "$inFolder" "$2"
  rsync -ahv --log-file="$3/$base3-$datetime.log" "$inFolder" "$3"

  ## Check all files for md5 checksum matches
  ## make a list of all the files
  inputFileList=$(find $1 -type f)

  ## loop over this list
  for inFile in $inputFileList; do
    inFileBase=$(basename "$inFile")

  ## make an md5 hash for the originals
    md5In=$(md5 -q "$inFile")

  ## search copied files 1 for the same filename
  ## and make an md5 hash
    out1File=$(find "$2" -type f -iname "$inFileBase")
    md5Out1=$(md5 -q "$out1File")
  ## compare these hashes, tell us when something is wrong and log it to a file
    if [[ "$md5In" != "$md5Out1" ]]; then
      echo "Hash mismatch! md5 checksum for file $inFile"
      echo "does not match checksum for $out1File"
      echo "Please varify files manually. This error will be logged."
      mkdir -p "$2/md5"
      echo $inFileBase >> "$2/md5/mismatch.log"
      echo "Input file hash - MD5" $inFile "=" $md5In >> "$2/md5/mismatch.log"
      echo "Copied file hash - MD5" $out1File "=" $md5Out1 >> "$2/md5/mismatch.log"
      echo "" >> "$2/md5/mismatch.log"
    fi

  ## do the same thing for the backup copy if the directory was supplied
    if [[ -n "$3" ]] || [[ -d "$3" ]]; then
      out2File=$(find "$3" -type f -iname "$inFileBase")
      md5Out2=$(md5 -q "$out2File")
      if [[ "$md5In" != "$md5Out2" ]]; then
        echo "Hash mismatch! md5 checksum for file $inFile"
        echo "does not match checksum for $out2File"
        echo "Please varify files manually. This error will be logged."
        mkdir -p "$3/md5"
        echo $inFileBase >> "$3/md5/mismatch.log"
        echo "Input file hash - MD5" $inFile "=" $md5In >> "$3/md5/mismatch.log"
        echo "Copied file hash - MD5" $out2File "=" $md5Out2 >> "$3/md5/mismatch.log"
        echo "" >> "$3/md5/mismatch.log"
      fi
    fi
  done

echo ""
echo "Copy completed."
echo ""

fi
