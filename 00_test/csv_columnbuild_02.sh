#!/usr/bin/env bash

csv_folder=$(echo "$1" | sed 's/^[ \t]*//;s/\/[ \t]*$//')
csv_allfiles="$csv_folder/*.csv"
csv_outputfile=$csv_folder.csv
echo -n "" > $csv_outputfile

for csv_inputfile in $csv_allfiles; do
  while read line && [[ $line != "" ]]; do
    projectname=$(echo $line | sed 's/^\([^,]*\),//')
    projectfound1=$(cat $csv_outputfile | grep -w $projectname)
    # echo "projectfound1 = $projectfound1" >> $csv_outputfile
if [[ ! $projectfound1 ]]; then
  textline=1
    # sed -e "${textline}s/$/${projectname}, /" >> $csv_outputfile
    echo "textline = $textline" >> $csv_outputfile
    echo "projectname = $projectname" >> $csv_outputfile
    # echo "$projectname, " >> $csv_outputfile
    for csv_foundfile in $csv_allfiles; do
    let "textline++"
    projectfound2=$(cat $csv_foundfile | grep -w $projectname)
    projectdata=$(echo $projectfound2 | sed 's/\,.*$//')
        if [[ $projectfound2 ]]; then
            # sed -e "${textline}s/$/$projectdata, /" >> $csv_outputfile
            echo "projectfound2 = $projectfound2" >> $csv_outputfile
            echo "textline = $textline" >> $csv_outputfile
            echo "projectdata = $projectdata" >> $csv_outputfile
          # echo "$projectdata, " >> $csv_outputfile
        fi
      done
    fi
  done < $csv_inputfile
done
