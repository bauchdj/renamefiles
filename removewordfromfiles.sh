#!/bin/bash
#cd /Volumes/XSD/Media/TV/Scooby\ Doo\ Mystery\ Incorporated/

move () {
	#name=${f/ 720p Salman Sk Silver RG/}
	#name=${name/ 720p Salman Sk SilverRG/}
	#name=${name/ 720p x264 Salman Sk Silver RG/}
	#name=${f/The Yogi Bear Show - /}
	#name=${f/Scooby Doo Mystery Incorporated /}

	#touch /Users/djbii/Desktop/test/$f
	name=$(echo "$f" | cut -d '[' -f1)
	name=$(echo "$name" | cut -d '(' -f1)
	name=$(echo "$name" | tr "-" " " | tr "." " ")
	name=$(echo "$name" | sed 's/ *$//g')

	mv "$f" "$name.mp4"
	#mv "$f" "firstlevel $f"
}

for f in *; do
	move
done

exit
