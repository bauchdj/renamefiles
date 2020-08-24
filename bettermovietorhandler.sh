#!/bin/bash
args=( "$@" )

if [[ "${args[0]}" == "move" ]] || [[ "${args[1]}" == "move" ]]; then
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
copynum=1

copies () {
	numfound=`ls "/$pwd/" | grep -v movies | tr " " . | tr . "(" | tr "(" " " | grep "$name" | wc -l | sed 's/^ *//g'`
	if [[ "$numfound" > 1 ]]
	then
		mv "$f" "$pwd/movies/$name-copy$copynum.$filetype"
		copynum=$(expr $copynum + 1)
	else
		mv "$f" "$pwd/movies/$name.$filetype"
	fi
}

getname () {
	name=$(echo "$d" | tr " " . | tr . "(")
	name=${name/([0-9][0-9][0-9][0-9]/_date_}
	name=$(echo "$name" | tr "(" " " | cut -d '_' -f1 | sed -e "s/ \{1,\}$//")
}

testing () { #creates files based on the names of movie folders in renames
	getname
	touch "/Volumes/XSD//Downloads/renames/$d/$name.mp4"
	touch "/Volumes/XSD//Downloads/renames/$d/$name.srt"
}

files () {
	#testing
if [[ "${f: -3}" == "mp4" ]]; then
	filetype="mp4"
	getname
	copies
fi
if [[ "${f: -3}" == "srt" ]]; then
	filetype="srt"
	getname
	copies
fi
}

for d in */; do
	if ! [ "$d" == "movies/" ]; then
		target="$pwd/${d%/}"
		cd "$target"
		for f in *; do
			files
		done
  fi
done

if [[ "${args[0]}" == "finalmove" ]] || [[ "${args[1]}" == "finalmove" ]]; then
		mv /Volumes/XSD/Downloads/renames/movies/* /Volumes/XSD/Media/Movies/
fi

exit
