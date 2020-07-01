#!/bin/bash

#date="2013"
#mkdir $date &> /dev/null
#for d in *$date; do
	#if ! [ "$d" == "$date" ]; then
		#mv "$d" "$date"
  #fi
#done

date=$(echo $PWD | sed 's/.*\(....\)/\1/') #only works for standard date directory
months=("January" "February" "March" "April" "May" "June" "July" "August" "September" "October" "November" "December")
nummonths=("01-January" "02-February" "03-March" "04-April" "05-May" "06-June" "07-July" "08-August" "09-September" "10-October" "11-November" "12-December")

movefiles () {
folder=$(echo ${nummonths[i]} $date)
mkdir "$folder" &> /dev/null
if ! [ "$d" == "$folder" ]; then
	mv "$d" "$folder"
fi
}

monthloop () {
for (( i=0; i<12; i++ ))
do
	SUB=${months[i]}
	if [[ "$d" == *"$SUB"* ]]; then
		movefiles
	fi
done
}

for d in *; do
	monthloop
done

exit
