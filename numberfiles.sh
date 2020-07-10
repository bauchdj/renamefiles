#!/bin/bash
#used to re-number camera pics
cc=$1 #have to store argument in the beginning
c=3000
numofzeros=("000" "00" "0" "")

numberfiles () {
name=${f/[0-9][0-9][0-9][0-9]/"$zeros""$c"}
mv $f $name
c=$(expr $c + 1)
}

fileloop () {
for f in *; do
	length=${#c}
	case $length in
 	1 )
		zeros=${numofzeros[0]}
 		;;
 	2 )
		zeros=${numofzeros[1]}
 		;;
 	3 )
		zeros=${numofzeros[2]}
 		;;
 	4 )
		zeros=${numofzeros[3]}
 		;;
	esac
	numberfiles
done
num=$(ls | wc -l)
compare=$(echo "$(($num + 3000))")
if [[ $c == $compare ]]; then
	c=$cc #stored value $1
	fileloop
fi
}

fileloop

exit
