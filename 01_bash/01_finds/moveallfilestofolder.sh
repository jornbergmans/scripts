#!/usr/bin/env bash
IFS=$'\n'

echo "Input directory to read from:"
read inDirRAW
inDir=$(echo "${inDirRAW}" | sed 's/^[ ]*//;s/[ ]*$//;s/\/*$//')

echo "Input directory to move files to:"
read outDirRAW
outDir=$(echo "${outDirRAW}" | sed 's/^[ ]*//;s/[ ]*$//;s/\/*$//')


# echo "++++$inDir++++"
# echo "++++$outDir++++"
if [ ! -d "$outDir" ]; then
  mkdir -p "$outDir"
fi

inFileList=$(find "$inDir" -type f | sort)

for inFile in $inFileList; do

  file=$(basename "$inFile")
  basefile="${file%.*}"
  ext="${file##*.}"

    if [[ ! -e "$outDir/$basefile.$ext" ]]; then
        # file does not exist in the destination directory
        mv "$inFile" "$outDir"
    else
        num=2
        while [[ -e "$outDir/$basefile-$num.$ext" ]]; do
            (( num++ ))
        done
        mv "$inFile" "$outDir/$basefile-$num.$ext"
    fi

done
