#!/bin/bash
rm /tmp/tmp* &> /dev/null
#cd /Volumes/XSD/Media/TV/Scooby\ Doo\ Mystery\ Incorporated/
tmp=$(mktemp /tmp/tmp)
tmptwo=$(mktemp /tmp/tmptwo)
tmpthree=$(mktemp /tmp/tmpthree)

for f in *; do
	#name=${f/ 720p Salman Sk Silver RG/}
	#name=${name/ 720p Salman Sk SilverRG/}
	#name=${name/ 720p x264 Salman Sk Silver RG/}
	#name=${f/The Yogi Bear Show - /}
	name=${f/Scooby Doo Mystery Incorporated /}
	mv "$f" "$name"
done

rm /tmp/tmp*
exit
