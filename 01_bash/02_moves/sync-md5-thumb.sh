#!/usr/bin/env bash
IFS=$'\n'

datetime=$(date +%Y%m%d-%H%M)
## Check if any / enough arguments are supplied
if [[ -z "$1" ]]; then
  echo "No arguments supplied."
  exit 1
fi

if [[ ! "$#" -ge 2 ]]; then
  echo "Please provide both input folder and output folder(s),"
  echo "starting with the input folder as source of the original files,"
  echo "then output folder(s) as destination(s) for copies."
  exit 1

  # echo "Would you like to create thumbnails of each video file?"
  # echo " "
  # PS3="Select: "
  # options=("Yes" "No")
  # select opt in "${options[@]}"
  #   do
  #     case $opt in
  #         "Yes")
  #
  #           echo "Creating thumbnails. Please wait."
  #           break
  #         ;;
  #         "No")
  #           echo "Skipping thumbnails."
  #           break
  #         ;;
  #         *) echo invalid option;;
  #     esac
  # done

      elif [[ "$#" -ge 2 ]]; then

        ## remove all leading and trailing whitespace from input folder
        ## and remove trailing slash ( / ) from input folder, so rsync will copy the whole folder, and not just its contents
        inFolder=$(echo "$1" | sed 's/^[ \t]*//;s/\/[ \t]*$//')
          base1=$(basename "$inFolder")
        ## Check whether the specified output directories exist
        ## If they don't, create them.
        if [[ ! -d "$2" ]]; then
          mkdir -p "$2"
        fi

        if [[ -n "$3" ]] || [[ ! -d "$3" ]]; then
          mkdir -p "$3"
        fi

        ## After creating the folder, start the data transfer using rsync.
        ## Let us know what you're doing, and log it.
          rsync -ahv --log-file="$2/$base1-$datetime.log" "$inFolder" "$2"
        if [[ -n "$3" ]] || [[ -d "$3" ]]; then
          rsync -ahv --log-file="$3/$base1-$datetime.log" "$inFolder" "$3"
        fi

        ## Check all files for md5 checksum matches
        ## make a list of all the files
        inputFileList=$(find $inFolder -type f -and -not -iname ".*")

        ## loop over this list
       for inFile in $inputFileList; do
          inFileBase=$(basename "$inFile")
          inFileFolder=$(dirname "$inFile")
          inFileSearchFolder=$(echo $inFileFolder | sed 's:^.*\/*\/::g')

        ## make an md5 hash for the originals
          md5In=$(md5 -q "$inFile")

        ## search copied files 1 for the same filename
        ## and make an md5 hash

          out1File=$(find "$2" -type f -and -iname "$inFileBase" -and -ipath "*/$inFileSearchFolder/*")
          md5Out1=$(md5 -q "$out1File")
          out1FileBase=$(basename $out1File)

          echo "Checking file integrity and creating thumbnail image for"
          echo $out1FileBase

            mkdir -p "$2/$base1-md5"
            echo "" >> "$2/$base1-md5/copyreport.log"
            echo $inFileBase >> "$2/$base1-md5/copyreport.log"
            echo "Input file location" - $inFile >> "$2/$base1-md5/copyreport.log"
            echo "Input file hash - MD5 =" $md5In >> "$2/$base1-md5/copyreport.log"
            echo "Copied file location" - $out1File >> "$2/$base1-md5/copyreport.log"
            echo "Copied file hash - MD5 =" $md5Out1 >> "$2/$base1-md5/copyreport.log"
            echo "" >> "$2/$base1-md5/copyreport.log"

      #echo "++++++++++"
      #echo "InFile"
      #echo $inFile
      #echo "++++++++++"
      #echo "inFileBase"
      #echo $inFileBase
      #echo "++++++++++"
      #echo "inFolderBase"
      #echo $inFileSearchFolder
      #echo "++++++++++"
      #echo "outFile"
      #echo $out1File
      #echo "++++++++++"

        ## compare these hashes, tell us when something is wrong and log it to a file
          if [[ "$md5In" != "$md5Out1" ]]; then
            echo "Hash mismatch! md5 checksum for file $inFile"
            echo "does not match checksum for $out1File"
            echo "Please varify files manually. This error will be logged."
            mkdir -p "$2/md5"
            echo $inFileBase >> "$2/$base1-md5/mismatch.log"
            echo "Input file hash - MD5" $inFile "=" $md5In >> "$2/$base1-md5/mismatch.log"
            echo "Copied file hash - MD5" $out1File "=" $md5Out1 >> "$2/$base1-md5/mismatch.log"
            echo "" >> "$2/$base1-md5/mismatch.log"
          fi

        ## create a thumbnail of the first, middle and last frames of the input video




    mkdir -p "$2/thumbnails"
    inFrames=$(     ffprobe -hide_banner -loglevel panic -pretty \
                    -select_streams v:0 -show_entries stream=nb_frames \
                    -of default=noprint_wrappers=1:nokey=1 -i $out1File)

    middleFrame=$(echo "$inFrames/2" | bc)
    frameCount=$(echo "$middleFrame-1" | bc)
    inFileBlank=$(echo ${inFileBase%.*})

    ffmpeg  -hide_banner -loglevel panic \
	    -y -i $out1File -frames 1 -q 5 \
            -vf "select=not(mod(n\,'$frameCount')),scale='240:-1',tile=3x1" \
            "$2/thumbnails/$inFileBlank.png"

  ## do the same thing for the backup copy if the directory was supplied
    if [[ -n "$3" ]] || [[ -d "$3" ]]; then

      out2File=$(find "$3" -type f -and -iname "$inFileBase" -and -ipath "*/$base1/")
      md5Out2=$(md5 -q "$out2File")
      out2FileBase=$(basename $out2File)

      echo "Checking file integrity and creating thumbnail image for"
      echo $out2FileBase

      mkdir -p "$3/$base1/md5"
      echo "" >> "$3/$base1-md5/copyreport.log"
      echo $inFileBase >> "$3/$base1-md5/copyreport.log"
      echo "Input file location" - $inFile >> "$3/$base1-md5/copyreport.log"
      echo "Input file hash - MD5 =" $md5In >> "$3/$base1-md5/copyreport.log"
      echo "Copied file location" - $out1File >> "$3/$base1-md5/copyreport.log"
      echo "Copied file hash - MD5 =" $md5Out1 >> "$3/$base1-md5/copyreport.log"
      echo "" >> "$3/$base1-md5/copyreport.log"

      if [[ "$md5In" != "$md5Out2" ]]; then
        echo "Hash mismatch! md5 checksum for file $inFile"
        echo "does not match checksum for $out2File"
        echo "Please varify files manually. This error will be logged."
        echo $inFileBase >> "$3/$base1-md5/mismatch.log"
        echo "Input file hash - MD5" $inFile "=" $md5In >> "$3/$base1-md5/mismatch.log"
        echo "Copied file hash - MD5" $out2File "=" $md5Out2 >> "$3/$base1-md5/mismatch.log"
        echo "" >> "$3/$base1-md5/mismatch.log"
      fi

    mkdir -p "$3/thumbnails"

    inFrames=$(     ffprobe -hide_banner -loglevel panic -pretty \
                    -select_streams v:0 -show_entries stream=nb_frames \
                    -of default=noprint_wrappers=1:nokey=1 -i $out2File)

    middleFrame=$(echo "$inFrames/2" | bc)
    frameCount=$(echo "$middleFrame-1" | bc)
    inFileBlank=$(echo ${inFileBase%.*})

		ffmpeg  -hide_banner -loglevel panic \
		-y -i $out2File -frames 1 -q 5 \
		-vf "select=not(mod(n\,'$frameCount')),scale='240:-1',tile=3x1" \
		"$3/thumbnails/$inFileBlank.png"

    fi

 done

echo ""
echo "Copy completed."
echo ""

fi
