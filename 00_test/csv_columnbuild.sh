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
<<<<<<< HEAD
csv_folder="$(echo $1 | sed 's/^[ \t]*//;s/\/[ \t]*$//')"
csv_allfiles="$csv_folder/*.csv"
csv_outputfile="$csv_folder.csv"
echo $csv_outputfile
=======
csv_folder=$(echo "$1" | sed 's/^[ \t]*//;s/\/[ \t]*$//')
csv_allfiles=$(find $csv_folder -maxdepth 1 -type f -iname "*.csv" -and -not -iname ".*")
csv_outputfile=$csv_folder.csv
>>>>>>> a4985ec00d86e9943bb57361dfd8abc15b70d6d2
echo -n "" > $csv_outputfile
for csv_inputfile in $csv_allfiles; do
  while read line && [[ $line != "" ]]; do
    projectname=$(echo $line | sed 's/^\([^,]*\),//')
    projectfound1=$(grep -w "$projectname" $csv_foundfile)
    if [[ ! $projectfound1 ]]; then
      textline=1
<<<<<<< HEAD
<<<<<<< HEAD
      echo "$projectname, " >> $csv_outputfile
      # awk -v l1="$textline" -v p="$projectname" 'NR == l1 {print p} {print}' >> $csv_outputfile
      # sed "$textline"s/$/"$projectfound, "/ >> $csv_outputfile
      # echo "$projectname, " >> $csv_outputfile
=======
       echo "textline = $textline" >> $csv_outputfile
       echo "projectname = $projectname" >> $csv_outputfile
          # awk -v l1="$textline" -v p="$projectname" 'NR == l1 {print p} {print}' >> $csv_outputfile
      # sed "${textline}s/$/${projectname}, /" >> $csv_outputfile
>>>>>>> a4985ec00d86e9943bb57361dfd8abc15b70d6d2
=======

          awk -v l1="$textline" -v p="$projectname" 'NR == l1 {print p}' >> $csv_outputfile
>>>>>>> 3cdee636f1074470ffe6ebdbc3489412431e1496
        for csv_foundfile in $csv_allfiles; do
        let "textline++"
        projectfound2=$(grep -w $projectname $csv_foundfile)
        projectdata=$(echo $projectfound2 | sed 's/\,.*$//')
        if [[ $projectfound2 ]]; then
<<<<<<< HEAD
          # echo -n ""
<<<<<<< HEAD
          echo "$projectdata, " >> $csv_outputfile
=======
         echo "textline = $textline" >> $csv_outputfile
         echo "projectfound2 = $projectfound2" >> $csv_outputfile
         echo "projectdata = $projectdata" >> $csv_outputfile
>>>>>>> a4985ec00d86e9943bb57361dfd8abc15b70d6d2
          # awk -v l2="$textline" -v d="$projectdata" 'NR == l2 {print d} {print}' >> $csv_outputfile
          # sed "${textline}s/$/${projectdata}, /" >> $csv_outputfile
                fi
=======
          awk -v l2="$textline" -v d="$projectdata" 'NR == l2 {print d}' >> $csv_outputfile
        fi
>>>>>>> 3cdee636f1074470ffe6ebdbc3489412431e1496
      done
    fi
  done < $csv_inputfile
done
#
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
