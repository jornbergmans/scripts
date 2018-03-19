#!/bin/bash

csvfile="$1"
csvfolder=$(dirname $csvfile)
csvbase=$(basename $csvfile)

echo -n "" > ${csvfile/.csv/.tmp.csv}
echo -n "[" >> ${csvfile/.csv/.tmp.csv}
echo -n "'DateTime', " >> ${csvfile/.csv/.tmp.csv}
  while read line && [ "$line" != "" ]; do
      # remove blank spaces and forward slashes
      # if [[ -n $(echo $csvbase | grep 'hammer') ]]; then
      # spacefix=$(echo $line | sed '/\(\..*\)/d;s/\///g;s/[[:space:]]/-/g')
      # fi
      # then proceed with clean foldernames
      projectname=$(echo $line | sed 's/^\([^,]*\),//')
        echo -n "'$projectname', " >> ${csvfile/.csv/.tmp.csv}
  done < $csvfile
echo -n "]," >> ${csvfile/.csv/.tmp.csv}
echo "" >> ${csvfile/.csv/.tmp.csv}
echo -n "[" >> ${csvfile/.csv/.tmp.csv}
csvdate=$(echo $csvfile | sed 's:.*_[0-9]\{4\}::g;s:\-[0-9]\{4\}.*::g')
echo -n "'$csvdate', " >> ${csvfile/.csv/.tmp.csv}
  while read line && [ "$line" != "" ]; do
    projectdata=$(echo $line | sed 's/^\([^,]*,\)\([^,]*\)/\2,\1/;s/\,$//' | sed 's/^\([^,]*\),//')
    echo -n "$projectdata, " >> ${csvfile/.csv/.tmp.csv}
    othercsvfound=$(find $csvfolder -mindepth 1 -maxdepth 1 -type f -and -iname "*.csv" -and -not -iname "$csvbase" -and -not -iname ".*" -and -not -iname "*.*.csv"| sort)
  done < $csvfile
echo -n "]," >> ${csvfile/.csv/.tmp.csv}
echo "" >> ${csvfile/.csv/.tmp.csv}
  for othercsvfile in $othercsvfound; do
    echo -n "[" >> ${csvfile/.csv/.tmp.csv}
    csvdate=$(echo $othercsvfile | sed 's:.*_[0-9]\{4\}::g;s:\-[0-9]\{4\}.*::g')
    echo -n "'$csvdate', " >> ${csvfile/.csv/.tmp.csv}
      while read otherline && [ "$otherline" != "" ]; do
        projectname=$(echo $otherline | sed 's/^\([^,]*\),//')
        projectdata=$(echo $otherline | sed 's/^\([^,]*,\)\([^,]*\)/\2,\1/;s/\,$//' | sed 's/^\([^,]*\),//')
        # echo -n "$projectdata," #>> ${csvfile/.csv/.tmp.csv}
        projectfound=$(cat $csvfile | grep -w $projectname | sed 's/^\([^,]*,\)\([^,]*\)/\2,\1/;s/\,$//')
        datafound=$(echo $projectfound | sed 's/^\([^,]*\),//')
          if [[ $projectfound ]]; then
            echo -n "$datafound, " >> ${csvfile/.csv/.tmp.csv}
          else
            echo -n "0," >> ${csvfile/.csv/.tmp.csv}
          fi
      done < $othercsvfile
    echo "]," >> ${csvfile/.csv/.tmp.csv}
  done

cat ${csvfile/.csv/.tmp.csv} | sed 's/\(\,[[:blank:]]\]\,\)/\]\,/g' > ${csvfile/.csv/.cat.csv}

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
#   cat ${csvfile/.csv/_temp.csv} > ${csvfile/.csv/_alldata.csv} && rm ${csvfile/.csv/_temp.csv}  #
# # | tr ' ' '\n' | sed 's/[^,]*,[^,]*,[^,]*,//;s/\,\,/,/'                                        #
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
#                                                                                                 #
# while read line from file, do                                                                   #
#     echo project1, project2, project3                                                           #
#                                                                                                 #
# echo newline                                                                                    #
#                                                                                                 #
#     echo projectdata1, projectdata2, projectdata3                                               #
#                                                                                                 #
# echo newline                                                                                    #
#                                                                                                 #
#     for otherfiles                                                                              #
#         while read line                                                                         #
#           find project1 & echo datafound                                                        #
#           find project2 & echo datafound                                                        #
#           find project3 & echo datafound                                                        #
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
