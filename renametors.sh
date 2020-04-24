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

for d in */; do
	if ! [ "$d" == "movies/" ]; then
		c=0
	    target="$pwd/${d%/}"
  		cd "$target"
		ls -1S . | head -1 >> "$tmpthree"
		file=$(tail -n 1 "$tmpthree")
		for f in *.mp4; do
			size=$(du -k "$f" | cut -f 1)
			if [[ $size -gt $minsize ]] && [ "$c" == 0 ]; then
				c=$(expr $c + 1)
				name=$(sed "${lc}q;d" "$secondtmp")
				if [ $lc == 1 ]; then prevname=$(echo $name); fi
				if ! [ "$prevname" == "$name" ]; then cpnum=1; fi
				numduplicates=$(ls -1 "$pwd/movies/" | grep "$name" | wc -l)
				if [ $cpnum == 1 ]; then
					for (( i=1; i<"$numduplicates"+1; ++i)); do 
						duplicate=$(ls -1 "$pwd/movies/" | grep "$name" | sed -n "$i"p)
						dpname=$(echo ${name}_dp${i}.mp4)
						mv "$pwd/movies/$duplicate" "$pwd/movies/$dpname"
					done
				fi
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
				prevname=$(echo $name)
				lc=$(expr $lc + 1)
			fi
		done
    fi
done

rm /tmp/tmp*
exit
