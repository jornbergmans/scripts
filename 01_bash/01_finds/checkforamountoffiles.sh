#!/usr/bin/env bash

# dirlist=$(find /ODIN/ARCHIVE/TO_ARCHIVE/ -maxdepth 1 -type d)
#
# echo "$dirlist"
# echo "+ + + + + + + + "
#   for d in $dirlist; do
#   fcount=$(find "$d" -type f -and -not -iname ".*" | wc -l)
# #  fcount=$(wc -l "$filesindir")
#      if [[ "$fcount" -lt 2 ]];
#       then echo $d
#      fi
#   done


for d in /THOR/VFX/ARCHIVE/TO_ARCHIVE/*;
  do based=$(basename "$d")

  if [[ -d /ODIN/ARCHIVE/TO_ARCHIVE/"$based" ]]; then
    echo "$d"
    echo "$based"
    rsync -avh "$d"/ /ODIN/ARCHIVE/TO_ARCHIVE/"$based"
  fi
done
