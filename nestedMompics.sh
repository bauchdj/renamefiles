#!/bin/bash
#cd /Users/djbii/Pictures/Mom\ Pics/folders\ inside\ 2011\ OLYMPUS\ Master\ 2/2011/
cd /Users/djbii/Pictures/Mom\ Pics/folders\ inside\ 2005-2006\ Christiana\ 1982/
#copiedpics="/Users/djbii/Desktop/2ndcopyMompics"
copiedpics="/Users/djbii/Desktop/3rdcopyMompics"
firstpwd=$PWD
mkdir $copiedpics &> /dev/null
c=1

copypics () {
	for f in *; do
		name=$(echo "$c"_"$f")
	 	cp "$f" "$copiedpics"/"$name"
		c=$(expr $c + 1)
	done
}

for levelOne in */; do
	nextlevel="$firstpwd/${levelOne%/}"
	cd "$nextlevel"
	#secondpwd=$PWD
	#for levelTwo in */; do
	#	nextlevel="$secondpwd/${levelTwo%/}"
	#	cd "$nextlevel"
		copypics
	#done
done

exit
