#!/bin/bash
rm /tmp/tmp* &> /dev/null
tmp=$(mktemp /tmp/tmp)
tmptwo=$(mktemp /tmp/tmptwo)
tmpthree=$(mktemp /tmp/tmpthree)
ls -1p | grep -v / > "$tmp"
minsize=575000
pwd=$PWD
lc=1
c=-1
cpnum=1
name=" "

while IFS="" read -r l || [ -n "$l" ]; do
	name=$(printf '%s\n' "$l")
	name=${name/(1080p/_quality_}
	name=$(echo "$name" | cut -d '_' -f1)
	echo "$name" >> "$tmptwo" 
done < "$tmp"

sed -i -e 's/ *$//' "$tmptwo"
secondtmp="$tmptwo"

changefiles () {
size=$(du -k "$f" | cut -f 1)
if [[ $size -gt $minsize ]]; then
	name=$(sed "${lc}q;d" "$secondtmp")
	file=$(sed "${lc}q;d" "$tmp")
	mv "$file" "$name".mp4
	lc=$(expr $lc + 1)
fi
}

for f in *.mp4; do
	changefiles
done

rm /tmp/tmp*
exit
