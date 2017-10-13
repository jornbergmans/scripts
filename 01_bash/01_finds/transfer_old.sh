#!/bin/bash

IFS=$'\n'

mkdir -p "/Volumes/TRANSFER/transfer-accounts-AV/mediamanager/xx_old"

for transfolders in $(find /Volumes/TRANSFER/transfer-accounts-AV/mediamanager/00_los/ -type d -and -not -newermt $(date -v -2m "+%Y-%m-%d") -and -not -newerct $(date -v -2m "+%Y-%m-%d")); do
mv "$transfolders" "/Volumes/TRANSFER/transfer-accounts-AV/mediamanager/xx_old/"
done

for transfiles in $(find /Volumes/TRANSFER/transfer-accounts-AV/mediamanager/00_los/ -type f -and -not -newermt $(date -v -2m "+%Y-%m-%d") -and -not -newerct $(date -v -2m "+%Y-%m-%d")); do
mv "$transfiles" "/Volumes/TRANSFER/transfer-accounts-AV/mediamanager/xx_old/"
done

for dotfiles in $(find /Volumes/TRANSFER/transfer-accounts-AV/mediamanager/00_los/ -type f -iname "._*"); do
	rm -f $dotfiles
done

for emptyfolders in $(find /Volumes/TRANSFER/transfer-accounts-AV/mediamanager/00_los/ -type d -empty); do
	mv "$emptyfolders" "/Volumes/TRANSFER/transfer-accounts-AV/mediamanager/xx_old/"
done
