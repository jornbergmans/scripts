#!/bin/bash

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
#
# while read line from file, do
#  if [[ ! $line ]]; then
#    echo newproject_from_line to first row                      --> How?!
#    echo data_from_newproject to second row in column
#     for newproject_from_line do
#      for othercsvs do
#       while read newprojectline
#        if [[ newproject_from_line ]]; then
#         echo data_from_newproject_in_othercsvs
#        fi
#       done
#      done
#     done
#   fi
# done
#
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
# DIFFERENT APPROACH
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
#
csv_folder="$1"
csv_allfiles="$csv_folder/*.csv"
csv_outputfile=$csv_folder.csv
echo -n "" > $csv_outputfile
for csv_inputfile in $csv_allfiles; do
  while read line && [[ $line != "" ]]; do
    projectname=$(echo $line | sed 's/^\([^,]*\),//')
    projectfound1=$(cat $csv_outputfile | grep -w $projectname)
    # | sed 's/^\([^,]*,\)\([^,]*\)/\2,\1/;s/\,$//'
    if [[ ! $projectfound1 ]]; then
      textline=1
      echo "projectdata = $projectname" >> $csv_outputfile
      # awk -v l1="$textline" -v p="$projectname" 'NR == l1 {print p} {print}' >> $csv_outputfile
      # sed "$textline"s/$/"$projectfound, "/ >> $csv_outputfile
      # echo "$projectname, " >> $csv_outputfile
        for csv_foundfile in $csv_allfiles; do
        textline=$(echo $textline + 1 | bc )
        projectfound2=$(cat $csv_foundfile | grep -w $projectname)
        # | sed 's/^\([^,]*,\)\([^,]*\)/\2,\1/;s/\,$//'
        projectdata=$(echo $projectfound2 | sed 's/\,.*$//')
        if [[ $projectfound2 ]]; then
          # echo -n ""
          echo "projectdata = $projectdata" >> $csv_outputfile
          # awk -v l2="$textline" -v d="$projectdata" 'NR == l2 {print d} {print}' >> $csv_outputfile
          # sed "$textline"s/$/"$projectdata, "/ >> $csv_outputfile
          # echo "$projectdata, " >> $csv_outputfile
        fi
      done
    fi
  done < $csv_inputfile
done
#
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
