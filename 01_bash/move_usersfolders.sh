#!/bin/bash
date=$(date +%Y%m%d)

echo "The date is" $date"."

if [ $date = 20171001 ]; then
mkdir -o /ODIN/USERS/
find /ODIN/_WORK -type d -maxdepth 1 -and -not -iname "*tesla*" -and -iname "*test*" -o -iname "*work*" -and -not -iname "*_p???????" -and -not -iname ".*"
#-exec mv {} /ODIN/USERS \;
else
 echo "It is not yet time..."
fi
