#!/bin/bash
args=( "$@" )

if [[ "${args[0]}" == "move" ]]; then
	cd /Volumes/XSD/Downloads &> /dev/null

	today=`ls -lt | awk '{print $6 " " $7}' | head -2 | tail -1`
	numdownmovies=`ls -lt | grep "$today" | wc -l | sed 's/^ *//g'`

	for (( i = $numdownmovies; i > 0; i-- )); do
		name=`ls -1t | sed -n "$i"p`
		mv "$name" "$PWD/renames/"
	done
fi

cd /Volumes/XSD/Downloads/renames &> /dev/null
pwd=$PWD
mkdir movies &> /dev/null

rename () {
	name=$(echo "$f" | tr " " . | tr . "(")
	name=${name/([0-9][0-9][0-9][0-9]/_date_}
	name=$(echo "$name" | tr "(" " " | cut -d '_' -f1)
	#mv "$f" "$pwd/movies/$name.$filetype"
}

files () {
for f in *; do
	if [[ "${f: -3}" == "mp4" ]]; then
		filetype="mp4"
		rename
	fi
	if [[ "${f: -3}" == "srt" ]]; then
		filetype="srt"
		rename
	fi
done
}

directory () {
target="$pwd/${d%/}"
cd "$target"
files
}

for d in */; do
	if ! [ "$d" == "movies/" ]; then
		directory
  fi
done

exit
