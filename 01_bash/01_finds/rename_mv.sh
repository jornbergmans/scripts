for name in $(find . -name "*.DNG"); do
	mv "${name}" "${name/.DNG/_0x.DNG}" ;
	echo "$name" ;
	
done