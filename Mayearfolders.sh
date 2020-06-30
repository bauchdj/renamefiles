#!/bin/bash
count=0
date="2020"
mkdir $date &> /dev/null
for d in *$date; do
	if ! [ "$d" == "$date" ]; then
		count=$(expr $count + 1)
		#echo "$d" "|" "$date" "|" "$count"
		mv "$d" "$date"
  fi
done

exit
