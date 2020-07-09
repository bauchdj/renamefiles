#!/bin/bash
cd /Users/djbii/Pictures/Mom\ Pics/
copiedpics="copyMompics"
pwd=$PWD
mkdir $copiedpics &> /dev/null

copypics () {
	for f in *; do
		if ! [[ $f == *".db" ]]; then
			name=${d/\//__$f}
			cp "$f" "$pwd"/"$copiedpics"/"$name"
		fi
	done
}

for d in */; do
	if ! [[ $d == *"$copiedpics"* ]]; then
		target="$pwd/${d%/}"
		cd "$target"
		copypics
	fi
done

exit
