#!/bin/bash
IFS=$'\n'

debug=$1
if [[ ! $debug = live ]]; then
	echo "Running in debug mode."
	echo "Set toggle 'live' to remove Scans folders."
elif [[ $debug = live ]]; then
	echo "Running in love mode..."
fi

# Maak een lijst van de folders die in Scans staan
scans=$(find /ODIN/BASELIGHT/Scans -type d -mindepth 1 -maxdepth 1 -not -iname ".*")

# Voor iedere folder die je in die lijst kan vinden;
for d in $scans; do

# Pak de naam van die folder, en zoek in de archives of er een folder met dezelfde naam bestaat
dirsc=$(basename $d)
arch=$(find /ODIN/BASELIGHT/archives/ -type d -mindepth 1 -not -iname ".*" -and -iname "$dirsc")
#echo $arch

# Als er een folder met dezelfde naam in archives bestaat, verwijder de Scans voor die archive
  if [[ ! -z $arch ]]; then
    echo "Found archive for $dirsc, removing Scans folder at $d, please wait."
	if [[ ! $debug = live ]]; then
		echo "Running in debug mode, not removing."
	else
		echo "Removing..."
		rm -Rf $d
		echo "Removed folder $d"
	fi
  fi

done
