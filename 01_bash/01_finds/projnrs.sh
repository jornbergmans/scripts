#/bin/bash

IFS=$'\n'
today=`date '+%d-%m-%Y'`;

#for editproj in 	$(find 	/Volumes/ -type f \
#						-and -ipath "/Volumes/ALPHA/01_*/*"
#						-or -ipath "/Volumes/BETA/01_*/*"
#						-or -ipath "/Volumes/DELTA/01_*/*"
#							-and \! -ipath "/Volumes/PHILIPS/01_*/*"
#							-and \! -ipath "/Volumes/RTL/01_*/*"
#							-and \! -ipath "/Volumes/TOMTOM/01_*/*"
#							-and \! -ipath "/Volumes/NINTENDO/01_*/*"

#						-and -iname "*1???????.txt"); do
#				echo "$editproj" >> /Volumes/ELEMENTS/10_SCRIPTS/99_outputedit_lopend.txt
#				sed 	-n '2,7p' "$text" >> /Volumes/ELEMENTS/10_SCRIPTS/99_outputedit_lopend.txt
#				echo ""	>> /Volumes/ELEMENTS/10_SCRIPTS/99_outputedit_lopend.txt

#done

mkdir -p /Volumes/ELEMENTS/10_SCRIPTS/99_output/lopend/$today/

# for proj in 	$(find /Volumes/ALPHA/01_ALPHA/ -type f -and -iname "*1???????.txt" -and -ipath "*00_Docs*" -and \! -ipath "*/01_Projects*" -and \! -ipath "*/04_Restored*"); do
# 				echo "$proj" >> /Volumes/ELEMENTS/10_SCRIPTS/99_output/lopend/$today/alpha_lopend_$today.txt
# 				sed 	-n '2,7p' "$proj" >> /Volumes/ELEMENTS/10_SCRIPTS/99_output/lopend/$today/alpha_lopend_$today.txt
# 				echo " "	>> /Volumes/ELEMENTS/10_SCRIPTS/99_output/lopend/$today/alpha_lopend_$today.txt
# done

for proj in 	$(find /Volumes/BETA/01_BETA/ -type f -and -iname "*1???????.txt" -and -ipath "*00_Docs*" -and \! -ipath "*/01_Projects*" -and \! -ipath "*/04_Restored*"); do
				echo "$proj" >> /Volumes/ELEMENTS/10_SCRIPTS/99_output/lopend/$today/beta_lopend_$today.txt
				sed 	-n '2,7p' "$proj" >> /Volumes/ELEMENTS/10_SCRIPTS/99_output/lopend/$today/beta_lopend_$today.txt
				echo " "	>> /Volumes/ELEMENTS/10_SCRIPTS/99_output/lopend/$today/beta_lopend_$today.txt
done
#
# for proj in 	$(find /Volumes/DELTA/01_DELTA/ -type f -and -iname "*1???????.txt" -and -ipath "*00_Docs*" -and \! -ipath "*/01_Projects*" -and \! -ipath "*/04_Restored*"); do
# 				echo "$proj" >> /Volumes/ELEMENTS/10_SCRIPTS/99_output/lopend/$today/delta_lopend_$today.txt
# 				sed 	-n '2,7p' "$proj" >> /Volumes/ELEMENTS/10_SCRIPTS/99_output/lopend/$today/delta_lopend_$today.txt
# 				echo " "	>> /Volumes/ELEMENTS/10_SCRIPTS/99_output/lopend/$today/delta_lopend_$today.txt
# done
#
#
# for proj in 	$(find /Volumes/PHILIPS/01_PHILIPS/ -type f -and -iname "*1???????.txt" -and -ipath "*00_Docs*" -and \! -ipath "*/01_Projects*" -and \! -ipath "*/04_Restored*"); do
# 				echo "$proj" >> /Volumes/ELEMENTS/10_SCRIPTS/99_output/lopend/$today/philips_lopend_$today.txt
# 				sed 	-n '2,7p' "$proj" >> /Volumes/ELEMENTS/10_SCRIPTS/99_output/lopend/$today/philips_lopend_$today.txt
# 				echo " "	>> /Volumes/ELEMENTS/10_SCRIPTS/99_output/lopend/$today/philips_lopend_$today.txt
# done
#
# for proj in 	$(find /Volumes/RTL/01_RTL/ -type f -and -iname "*1???????.txt" -and -ipath "*00_Docs*" -and \! -ipath "*/01_Projects*" -and \! -ipath "*/04_Restored*"); do
# 				echo "$proj" >> /Volumes/ELEMENTS/10_SCRIPTS/99_output/lopend/$today/rtl_lopend_$today.txt
# 				sed 	-n '2,7p' "$proj" >> /Volumes/ELEMENTS/10_SCRIPTS/99_output/lopend/$today/rtl_lopend_$today.txt
# 				echo " "	>> /Volumes/ELEMENTS/10_SCRIPTS/99_output/lopend/$today/rtl_lopend_$today.txt
# done
#
# for proj in 	$(find /Volumes/TOMTOM/01_TOMTOM/ -type f -and -iname "*1???????.txt" -and -ipath "*00_Docs*" -and \! -ipath "*/01_Projects*" -and \! -ipath "*/04_Restored*"); do
# 				echo "$proj" >> /Volumes/ELEMENTS/10_SCRIPTS/99_output/lopend/$today/tomtom_lopend_$today.txt
# 				sed 	-n '2,7p' "$proj" >> /Volumes/ELEMENTS/10_SCRIPTS/99_output/lopend/$today/tomtom_lopend_$today.txt
# 				echo " "	>> /Volumes/ELEMENTS/10_SCRIPTS/99_output/lopend/$today/tomtom_lopend_$today.txt
# done
#
# for proj in 	$(find /Volumes/NINTENDO/01_NINTENDO/ -type f -and -iname "*1???????.txt" -and -ipath "*00_Docs*" -and \! -ipath "*/01_Projects*" -and \! -ipath "*/04_Restored*"); do
# 				echo "$proj" >> /Volumes/ELEMENTS/10_SCRIPTS/99_output/lopend/$today/nintendo_lopend_$today.txt
# 				sed 	-n '2,7p' "$proj" >> /Volumes/ELEMENTS/10_SCRIPTS/99_output/lopend/$today/nintendo_lopend_$today.txt
# 				echo " "	>> /Volumes/ELEMENTS/10_SCRIPTS/99_output/lopend/$today/nintendo_lopend_$today.txt
# done

	for files in $(find /Volumes/ELEMENTS/10_SCRIPTS/99_output/lopend/$today/ -iname "*.txt"); do
				sed -i .bak '/^$/d' "$files"
	done

open "/Volumes/ELEMENTS/10_SCRIPTS/99_output/lopend/$today/"
