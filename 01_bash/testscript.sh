#!/bin/bash

IFS=$'\n'

# # #

name=$1

	for meta in $(find "$name" -type f \
					\( 	\
					-iname "._*" -and \
					-iname ".DS*" -and \
					-iname ".afpDel*" \
					\) \
			 	); do

			 	echo $meta				
#			 	rm -fv $meta
	done