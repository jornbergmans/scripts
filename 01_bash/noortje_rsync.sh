#!/bin/bash

servcheck=$(ping -c 1 192.168.178.15)

if grep -q "0.0% packet loss" <<<$servcheck; then
  rsync -azvhn --delete -e ssh /Users/noortjedekeijzer/Desktop/ noortje@192.168.178.15:/volume1/noortje/Desktop
  rsync -azvhn -e ssh /Users/noortjedekeijzer/WORK/ noortje@192.168.178.15:/volume1/noortje/WORK
else
  echo "Server seems to be offline" && exit
fi
