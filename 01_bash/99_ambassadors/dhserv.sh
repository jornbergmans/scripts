#!/bin/bash

IFS=$'\n'

date +%Y%m%d-%H%M > /AMBASSADORS_SHARED/TRANSPORT/VTR/dh0_odin.txt && du -hd 0 /ODIN >> /AMBASSADORS_SHARED/TRANSPORT/VTR/dh0_odin.txt
date +%Y%m%d-%H%M > /AMBASSADORS_SHARED/TRANSPORT/VTR/dh0_hammer.txt && du -hd0 /HAMMER >> /AMBASSADORS_SHARED/TRANSPORT/VTR/dh0_hammer.txt
date +%Y%m%d-%H%M > /AMBASSADORS_SHARED/TRANSPORT/VTR/dh0_shared.txt && du -hd 0 /AMBASSADORS_SHARED>> /AMBASSADORS_SHARED/TRANSPORT/VTR/dh0_shared.txt
date +%Y%m%d-%H%M > /AMBASSADORS_SHARED/TRANSPORT/VTR/dh0_rushes.txt && du -hd 0 /RUSHES>> /AMBASSADORS_SHARED/TRANSPORT/VTR/dh0_rushes.txt
