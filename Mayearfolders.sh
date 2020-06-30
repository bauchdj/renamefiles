#!/bin/bash

#date="2020"
#mkdir $date &> /dev/null
#for d in *$date; do
	#if ! [ "$d" == "$date" ]; then
		#mv "$d" "$date"
  #fi
#done

monthloop () {
for m in ${months[@]}; do
	SUB=$m
	if [[ "$d" == *"$SUB"* ]]; then
		mkdir "$SUB" &> /dev/null
		if ! [ "$d" == "$SUB" ]; then
			mv "$d" "$SUB"
		fi
	fi
done
}

months=("January" "February" "March" "April" "May" "June" "July" "August" "September" "October" "November" "December")
for d in *; do
	monthloop
done
exit
