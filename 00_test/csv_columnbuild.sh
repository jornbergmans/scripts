#!/usr/bin/env bash

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
csv_folder=$(echo "$1" | sed 's/^[ \t]*//;s/\/[ \t]*$//')
csv_allfiles=$(find $csv_folder -maxdepth 1 -type f -iname "*.csv" -and -not -iname ".*")
csv_outputfile=$csv_folder.csv
echo -n "" > $csv_outputfile
for csv_inputfile in $csv_allfiles; do
  while read line && [[ $line != "" ]]; do
    projectname=$(echo $line | sed 's/^\([^,]*\),//')
    projectfound1=$(grep -w "$projectname" $csv_foundfile)
    if [[ ! $projectfound1 ]]; then
      textline=1

          awk -v l1="$textline" -v p="$projectname" 'NR == l1 {print p}' >> $csv_outputfile
        for csv_foundfile in $csv_allfiles; do
        let "textline++"
        projectfound2=$(grep -w $projectname $csv_foundfile)
        projectdata=$(echo $projectfound2 | sed 's/\,.*$//')
        if [[ $projectfound2 ]]; then
          awk -v l2="$textline" -v d="$projectdata" 'NR == l2 {print d}' >> $csv_outputfile
        fi
      done
    fi
  done < $csv_inputfile
done
#
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
