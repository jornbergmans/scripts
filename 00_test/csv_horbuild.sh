#!/bin/bash

csvfile="$1"
csvfolder=$(dirname $csvfile)
# csvbase=$(basename $csvfile)

echo -n "" > ${csvfile/.csv/_temp.csv}

  while read line && [ "$line" != "" ]; do
        # # remove blank spaces and forward slashes
        # if [[ -n $(echo $csvbase | grep 'hammer') ]]; then
        # spacefix=$(echo $line | sed '/\(\..*\)/d;s/\///g;s/[[:space:]]/-/g')
        # fi
        # # then proceed with clean foldernames
        projectname=$(echo $spacefix | sed 's/^\([^,]*\),//')
        projectdata=$(echo $spacefix | sed 's/^\([^,]*,\)\([^,]*\)/\2,\1/;s/\,$//' | sed 's/^\([^,]*\),//')
          echo -n "$projectname,$projectdata" >> ${csvfile/.csv/_temp.csv}
        othercsvfound=$(find $csvfolder -mindepth 1 -maxdepth 1 -type f -and -not -iname "$csvfile" -and -not -iname "*_temp*" -and -not -iname "*_alldata.csv" -and -iname "*.csv" -and -not -iname ".*" | sort)
    for othercsvfile in $othercsvfound; do
         projectfound=$(cat $othercsvfile | grep -w $projectname | sed 's/^\([^,]*,\)\([^,]*\)/\2,\1/;s/\,$//')
         datafound=$(echo $projectfound | sed 's/^\([^,]*\),//')
          if [[ $projectfound ]]; then
              echo -n ",$datafound" >> ${csvfile/.csv/_temp.csv}
          else
              echo -n ",0" >> ${csvfile/.csv/_temp.csv}
          fi
    done
  echo " " >> ${csvfile/.csv/_temp.csv}
done < $csvfile
  cat ${csvfile/.csv/_temp.csv} > ${csvfile/.csv/_alldata.csv} && rm ${csvfile/.csv/_temp.csv}
# | tr ' ' '\n' | sed 's/[^,]*,[^,]*,[^,]*,//;s/\,\,/,/'
