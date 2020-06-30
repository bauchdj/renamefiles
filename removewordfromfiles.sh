#!/bin/bash
#cd /Volumes/XSD/Media/TV/Scooby\ Doo\ Mystery\ Incorporated/

for f in *; do
	#name=${f/ 720p Salman Sk Silver RG/}
	#name=${name/ 720p Salman Sk SilverRG/}
	#name=${name/ 720p x264 Salman Sk Silver RG/}
	#name=${f/The Yogi Bear Show - /}
	#name=${f/Scooby Doo Mystery Incorporated /}
	#mv "$f" "$name"
	mv "$f" "Season 1 $f"
done

exit
