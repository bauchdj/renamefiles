#!/bin/bash
downloads="/Volumes/XSD/Downloads"
rename="/Volumes/XSD/Downloads/renames"
#downloads="/Users/djbii/Desktop/test"
#rename="/Users/djbii/Desktop/test/renames"

args=( "$@" )
if [[ "${args[0]}" == "move" ]] || [[ "${args[1]}" == "move" ]]; then
	cd "$downloads" &> /dev/null

	today=`ls -lt | awk '{print $6 " " $7}' | head -2 | tail -1`
	numdownmovies=`ls -lt | grep "$today" | wc -l | sed 's/^ *//g'`

	for (( i = $numdownmovies; i > 0; i-- )); do
		name=`ls -1t | sed -n "$i"p`
		mv "$name" "$PWD/renames/"
	done
fi

cd "$rename" &> /dev/null
pwd=$PWD
mkdir movies &> /dev/null
copynum=1

copies () {
	if [ $copynum == 1 ]
	then # names first one of the numerous same named movies normally
		mv "$f" "$pwd/movies/$name.$filetype"
		copynum=$(expr $copynum + 1)
	else # appends _copy_$copynum to the $name
		namenum=$(expr $copynum - 1)
		cpname=$(echo "${name}-copy_${namenum}")
		mv "$f" "$pwd/movies/$cpname.$filetype"
		copynum=$(expr $copynum + 1)
	fi
}

rename () {
	numfound=`ls "/$pwd/" | grep -v movies | tr " " . | tr . "(" | tr "(" " " | grep "$name" | wc -l | sed 's/^ *//g'`
	if [[ "$numfound" > 1 ]]
	then
		copies
	else
		mv "$f" "$pwd/movies/$name.$filetype"
	fi
}

files () {
case "${f: -3}" in
	"mp4" )
	filetype="mp4"
		;;
	"mkv" )
	filetype="mkv"
		;;
	"srt" )
	filetype="srt"
		;;
esac
prevname="$name" # stores name before it changes
name=$(echo "$d" | tr " " . | tr . "(") # 3 lines extract name from folders
name=${name/([0-9][0-9][0-9][0-9]/_date_}
name=$(echo "$name" | tr "(" " " | cut -d '_' -f1 | sed -e "s/ \{1,\}$//" | sed -e "s/\///g")
if ! [[ $prevname == $name ]]; then copynum=1; fi # resets copynum to one if name changes
rename
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
