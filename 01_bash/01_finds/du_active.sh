#!/usr/bin/env bash
IFS=$'\n'

datetime=$(date +%Y%m%d-%H%M)

# # # # # # # # # # # #
# The Hammer Chapter  #
# # # # # # # # # # # #

# echo "DISK USAGE ON /AMBASSADORS_SHARED, FOLDER PATH" > /AMBASSADORS_SHARED/USERS/Jorn/servsizes/hammer/hammer_$datetime.csv
du -kd1 /AMBASSADORS_SHARED | sed $'s/[[:blank:]]/,/;s/\/.*\///' | sort -nr >> /AMBASSADORS_SHARED/USERS/Jorn/servsizes/hammer/shared_$datetime.csv
# echo " "
# echo "DISK USAGE ON /HAMMER, FOLDER PATH" >> /AMBASSADORS_SHARED/USERS/Jorn/servsizes/hammer/hammer_$datetime.csv
du -kd1 /HAMMER | sed $'s/[[:blank:]]/,/;s/\/.*\///' | sort -nr >> /AMBASSADORS_SHARED/USERS/Jorn/servsizes/hammer/hammer_$datetime.csv

# # # # # # # # # # # #
#    The Projects     #
# # # # # # # # # # # #

find /AMBASSADORS_SHARED/PROJECTS/ -type d -and -iname "*_p1??????" -and -not -ipath "*_p1??????/*_p1??????*" -exec du -kd0 {} \; \
  | sed 's/[[:blank:]]/,/g;s/\/.*\///' | sort -nr  >> /AMBASSADORS_SHARED/USERS/Jorn/servsizes/projs/projdirs_$datetime.csv


# # # # # # # # # # # #
#   The Odin Chapter  #
# # # # # # # # # # # #

echo "DISK USAGE ON ODIN, FOLDER PATH" > /AMBASSADORS_SHARED/USERS/Jorn/servsizes/odin/odin_$datetime.csv
du -kd1 /ODIN | sed $'s/[[:blank:]]/,/;s/\/.*\///' | sort -nr >> /AMBASSADORS_SHARED/USERS/Jorn/servsizes/odin/odin_$datetime.csv

find /ODIN/_WORK/ -type d -and -iname "*_p1??????" -and -not -ipath "*_p1??????/*_p1??????*" -exec du -kd0 {} \; \
  | sed 's/[[:blank:]]/,/g;s/\/.*\///' \
  | sort -nr >> /AMBASSADORS_SHARED/USERS/Jorn/servsizes/work/workdirs_$datetime.csv

find /ODIN/LIBRARY/pFINALS/ -type d -and -iname "*_p1??????" -and -not -ipath "*_p1??????/*_p1??????*" -exec du -kd0 {} \; | sed 's/[[:blank:]]/,/g;s/\/.*\///' \
  | sort -nr >> /AMBASSADORS_SHARED/USERS/Jorn/servsizes/fins/pfins_$datetime.csv

# # # # # # # # # # # #
#    OBSOLETE CODE    #
# # # # # # # # # # # #

# workdirs=$(find /ODIN/_WORK/ -type d -and -iname "*_p1??????" -and -not -ipath "*_p1??????*/*_p1??????*" -and -not -iname ".*" | sort)
# for workdir in $workdirs; do
#   du -kd0 $workdir | sed $'s/[[:blank:]]/,/g;s/\/.*\///' >> /AMBASSADORS_SHARED/USERS/Jorn/servsizes/odin/workdirs_$datetime.csv
# done
# cat /AMBASSADORS_SHARED/USERS/Jorn/servsizes/odin/workdirs_$datetime.csv | sort -nr > /AMBASSADORS_SHARED/USERS/Jorn/servsizes/odin/workdirs_$datetime-sorted.csv
