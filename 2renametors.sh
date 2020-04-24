#!/bin/bash
rm /tmp/tmp* &> /dev/null
#cd /Volumes/XSD/Downloads/refiles &> /dev/null
#cd /Users/Jigsy/Desktop/test/ &> /dev/null
tmp=$(mktemp /tmp/tmp)
tmptwo=$(mktemp /tmp/tmptwo)
tmpthree=$(mktemp /tmp/tmpthree)
ls -1d -- */ > "$tmp"
minsize=575000
#minsize=600
pwd=$PWD
lc=1
c=-1
cpnum=1
name=" "
mkdir movies &> /dev/null

while IFS="" read -r l || [ -n "$l" ]; do
	name=$(printf '%s\n' "$l")
	name=$(echo "$name" | tr " " . | tr . "(")
	name=${name/([0-9][0-9][0-9][0-9]/_date_}
	name=$(echo "$name" | tr "(" " " | cut -d '_' -f1)
	echo "$name" >> "$tmptwo" 
done < "$tmp"

sed -i -e 's/ *$//' "$tmptwo"
secondtmp="$tmptwo"
sed -i '' '/movies/d' "$secondtmp"

rename () {
checkfolderdups=$(cat "$secondtmp" | grep "$name" | wc -l)
if [[ $checkfolderdups -gt 1 ]]
then
	if [ $cpnum == 1 ]
	then
		mv "$file" "$name".mp4
		mv "$name".mp4 "$pwd/movies/$name".mp4
		cpnum=$(expr $cpnum + 1)
	else 
		namenum=$(expr $cpnum - 1)
		cpname=$(echo ${name}_copy_${namenum}.mp4)
		mv "$file" "$cpname"
		mv "$cpname" "$pwd/movies/$cpname"
		cpnum=$(expr $cpnum + 1)
fi
else
	mv "$file" "$name".mp4
	mv "$name".mp4 "$pwd/movies/$name".mp4
fi
}

duplicates () {
numduplicates=$(ls -1 "$pwd/movies/" | grep "$name" | wc -l)
if [ $cpnum == 1 ]; then
	for (( i="$numduplicates"; i>0; --i)); do 
		duplicate=$(ls -t1 "$pwd/movies/" | grep "$name" | tail -1)
		#duplicate=$(ls -t1 "$pwd/movies/" | grep "$name" | sed -n "$numduplicates"p)
		touch "$pwd/movies/$duplicate"
		dpname=$(echo ${name}_duplicate_${i}.mp4)
		mv "$pwd/movies/$duplicate" "$pwd/movies/$dpname"
	done
fi
}

changefiles () {
size=$(du -k "$f" | cut -f 1)
if [[ $size -gt $minsize ]] && [ "$c" == 0 ]; then
	c=$(expr $c + 1)
	name=$(sed "${lc}q;d" "$secondtmp")
	if [ $lc == 1 ]; then prevname=$(echo $name); fi
	if ! [ "$prevname" == "$name" ]; then cpnum=1; fi
	duplicates
	rename
	prevname=$(echo $name)
	lc=$(expr $lc + 1)
fi
}

files () {
for f in *.mp4; do
	changefiles
done
}

directory () {
c=0
target="$pwd/${d%/}"
cd "$target"
ls -1S . | head -1 >> "$tmpthree"
file=$(tail -n 1 "$tmpthree")
files
}

for d in */; do
	if ! [ "$d" == "movies/" ]; then
		directory
    fi
done
rm /tmp/tmp*
exit
