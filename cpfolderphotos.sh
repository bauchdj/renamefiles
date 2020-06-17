#!/bin/bash
rm /tmp/tmp* &> /dev/null
cd /Users/djbii/Desktop/Mom\ Pics/
mkdir /Users/djbii/Desktop/CopiedPics/ &>/dev/null
tmp=$(mktemp /tmp/tmp)
tmptwo=$(mktemp /tmp/tmptwo)
tmpthree=$(mktemp /tmp/tmpthree)
ls -1dp */ > "$tmp"
pwd=$PWD

for d in */; do
	folder=${d/\//}
	target="$pwd/${d%/}"
	cd "$target"
	c=1
	for f in *; do
		filetype=$(echo $f | cut -d '.' -f2)
		cp "$f" "/Users/djbii/Desktop/CopiedPics/$folder-$c.$filetype"
		c=$((c+1))
	done
done

rm /tmp/tmp*
exit
