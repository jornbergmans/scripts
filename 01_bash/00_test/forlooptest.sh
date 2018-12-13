#!/usr/bin/env bash
		for version in {Frog,Mole,Dog}; do
			for length in {15,25}; do
				videopath="/ODIN/LIBRARY/pFINALS/FEDERAL-OFFICE-OF-PUBLIC-HEALTH_p1806057/"
				audiopath="/AMBASSADORS_SHARED/PROJECTS/FEDERAL-OFFICE-OF-PUBLIC-HEALTH_p1806057/SOUND/Internal/20181026/-3dB"
				country="FR"
				video=$(find $videopath -type  f -and -ipath "*/$country/*" -and -iname "*$version*" -and -iname "*$length*" -and -iname "*.mov" -and -not -ipath "*GENERIC*")
				audio=$(find $audiopath -type  f -and -ipath "*/$country/*" -and -iname "*$version*" -and -iname "*$length*" -and -iname "*.wav")
				echo "Video file is $video"
				echo "Audio file is $audio"
					python3 /Users/VTR02/Documents/scripts/02_python/rl.py "$video" "$audio" 16000 /Volumes/ftpdata/PROJECTS/FEDERAL-OFFICE-OF-PUBLIC-HEALTH_p1806057/20181026_DELIVERY/OLV/$country/
			done
		done
