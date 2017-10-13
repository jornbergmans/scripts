#/bin/bash 

for f in $(find . -type f -and -iname "*.prproj" -or -iname "*.aep" -or -iname "*.txt" ) ; do
		echo "$f" \;
		
	done
