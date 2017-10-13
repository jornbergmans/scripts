#!/bin/bash
IFS=$'\n'


# find dironsource
# find dirondest

# for $dironsource 
# 	if test -d $dirondest 
# 		then cp -Rv $dironsource
# 	fi

# done

# DSRC=$(find $1 -depth -type d)
DDEST=$2



# for sourcedirs in $(find $1 -type d); do 
# 	basename "$sourcedirs" 
# done

# echo $dirsonsource
# echo $sourcedirs

# dirsondest=$(find $2 -type d)
# for destdirs in $dirsondest; do 
# 	basename "$dirsondest" 
# done


# for dirs in $sourcedir; do
# # 	if [ 
# 		test -d "$dirsonsource"
# # 		 = true ] ; then
# # 		cp -Rv "$dirsonsource"
# # 	fi
# done

for DSRC in $(find "$1" -depth -type d); do

base1=$(basename "$DSRC")
base2=$(basename "$DDEST")
count=$(find $DSRC -mindepth 1 -maxdepth 1 -type f -not -iname ".*" | wc -l)

	if [ \! -e $DSRC ] ; 
	# if [ $count >= 1 ] ;
		then echo $DSRC will be copied to $DDEST
		# then cp -Rfv $DSRC $DDEST
		# else echo $base1 exists on $DDEST
	fi
done
