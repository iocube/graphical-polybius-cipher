#!/bin/bash

## Get ciphertext
# Assign first parameter string as ciphertext
if [[ ! -z $1 ]]; then
	ciphertext="$1"
	shift
else echo "No ciphertext given." && exit 1
fi
ciphertext="13 24 35 23 15 42"  #debug
if [[ $ciphertext =~ ([1-5][0-9] ?) ]];then
	echo "Input validated."
else echo "Invalid input." && exit 1
fi

## Declare alphabet square
# Automated

declare -A alphabet
alphabet[row1]="A B C D E"
alphabet[row2]="F G H IJ K"
alphabet[row3]="L M N O P"
alphabet[row4]="Q R S T U"
alphabet[row5]="V W X Y Z"

for bifid_letter in ${ciphertext};do
	row=$(echo "${bifid_letter:0:1}")
	column=$(echo "${bifid_letter:1:1}")
	decoded_letter=$(echo "${alphabet[row"$row"]}" | cut -d' ' -f"$column")
	echo "$decoded_letter"
done

