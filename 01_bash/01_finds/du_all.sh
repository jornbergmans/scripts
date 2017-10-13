#!/bin/bash 

IFS=$'\n'
today=`date '+%d-%m-%Y'`;

mkdir -p /Volumes/ELEMENTS/10_SCRIPTS/99_output/DISK-USAGE/

du -hd 2 /Volumes/ABNAMRO/	>> /Volumes/ELEMENTS/10_SCRIPTS/99_output/DISK-USAGE/abn_$today.txt
du -hd 2 /Volumes/ALPHA/	>> /Volumes/ELEMENTS/10_SCRIPTS/99_output/DISK-USAGE/alpha_$today.txt
du -hd 2 /Volumes/BETA/		>> /Volumes/ELEMENTS/10_SCRIPTS/99_output/DISK-USAGE/beta_$today.txt
du -hd 2 /Volumes/CGI/		>> /Volumes/ELEMENTS/10_SCRIPTS/99_output/DISK-USAGE/cgi_$today.txt
du -hd 2 /Volumes/DELTA/	>> /Volumes/ELEMENTS/10_SCRIPTS/99_output/DISK-USAGE/delta_$today.txt
du -hd 2 /Volumes/DOUGLAS/	>> /Volumes/ELEMENTS/10_SCRIPTS/99_output/DISK-USAGE/douglas_$today.txt
du -hd 2 /Volumes/EFTELING/	>> /Volumes/ELEMENTS/10_SCRIPTS/99_output/DISK-USAGE/eftling_$today.txt
du -hd 2 /Volumes/ELEMENTS/	>> /Volumes/ELEMENTS/10_SCRIPTS/99_output/DISK-USAGE/elements_$today.txt
du -hd 2 /Volumes/FINALS/	>> /Volumes/ELEMENTS/10_SCRIPTS/99_output/DISK-USAGE/finals_$today.txt
du -hd 2 /Volumes/KRUIDVAT/	>> /Volumes/ELEMENTS/10_SCRIPTS/99_output/DISK-USAGE/kruidvat_$today.txt
du -hd 2 /Volumes/LITE/		>> /Volumes/ELEMENTS/10_SCRIPTS/99_output/DISK-USAGE/lite_$today.txt
du -hd 2 /Volumes/NINTENDO/	>> /Volumes/ELEMENTS/10_SCRIPTS/99_output/DISK-USAGE/nintendo_$today.txt
du -hd 2 /Volumes/OMEGA/	>> /Volumes/ELEMENTS/10_SCRIPTS/99_output/DISK-USAGE/omega_$today.txt
du -hd 2 /Volumes/PHILIPS/	>> /Volumes/ELEMENTS/10_SCRIPTS/99_output/DISK-USAGE/philips_$today.txt
du -hd 2 /Volumes/Phi/		>> /Volumes/ELEMENTS/10_SCRIPTS/99_output/DISK-USAGE/phi_$today.txt
du -hd 2 /Volumes/RAW/		>> /Volumes/ELEMENTS/10_SCRIPTS/99_output/DISK-USAGE/raw_$today.txt
du -hd 2 /Volumes/RTL/		>> /Volumes/ELEMENTS/10_SCRIPTS/99_output/DISK-USAGE/rtl_$today.txt
du -hd 2 /Volumes/SOUND/	>> /Volumes/ELEMENTS/10_SCRIPTS/99_output/DISK-USAGE/sound_$today.txt
du -hd 2 /Volumes/TOMTOM/	>> /Volumes/ELEMENTS/10_SCRIPTS/99_output/DISK-USAGE/tomtom_$today.txt