#!/bin/bash

usage_msg () {
	echo -e "Usage:\n$0 encrypt <plaintext> \n$0 decrypt <ciphertext>"
	echo -e "echo <plaintext> | $0 encr\necho <ciphertext> | $0 decr"
}

## Check starting params
if [[ ! -z $1 ]];then
	mode="$1"
else
	echo "No input parameter given." && usage_msg && exit 1
fi


## Assign and check input
if [[ ! -z $2 ]]; then
	text="$2"
elif [[ -z $2 ]];then while IFS= read line;do text="$line" ; done
else echo "No ciphertext given." && exit 1
fi

## Declare alphabet square
declare -A alphabet
alphabet[row1]="A B C D E"
alphabet[row2]="F G H IJ K"
alphabet[row3]="L M N O P"
alphabet[row4]="Q R S T U"
alphabet[row5]="V W X Y Z"


## Main
case "$mode" in
	enc|encrypt)
		## Get plaintext, transform and perform checks
		plaintext="$(echo $text | sed -E 's/([[:alpha:]])/ \1 /g' | tr '[:lower:]' '[:upper:]' )"
		if [[ $plaintext =~ [0-9] ]];then 
			echo "Warning: Numbers will not be encrypted."
		fi
		
		ciphertext=""
		for letter in ${plaintext};do 
			for (( i=1; i<=5 ; i++ ));do
				if [[ $letter =~ [[:digit:]] ]];then ciphertext+="$letter " ; break ; fi
				if [[ $(echo ${alphabet[row$i]} | grep -q "$letter" && echo "1" ) -eq 1 ]];then
					counter=1; for letter_element in ${alphabet[row$i]};do
						if [[ $letter_element =~ $letter ]];then
							ciphertext+="$i$counter "
						else counter=$((counter + 1))
						fi
					done
				
				fi
			done
		done
		echo "$ciphertext"

	;;
	dec|decrypt)
		## Get ciphertext and perform checks
		ciphertext="$text"
		if [[ ! $ciphertext =~ ([1-5][0-9] ?) ]];then
		        echo "Invalid input." && exit 1
		fi

		plaintext=""
		for bifid_letter in ${ciphertext};do
			#W1 Interpret single digits are actual numbers or ignore ## Choose behaviour below
			if [[ ! $bifid_letter =~ [0-9][0-9] ]];then plaintext+="$bifid_letter" ; continue ; fi
			#if [[ ! $bifid_letter =~ [0-9][0-9] ]];then continue ; fi
			#W1
			
			row=$(echo "${bifid_letter:0:1}")
			column=$(echo "${bifid_letter:1:1}")
			decoded_letter=$(echo "${alphabet[row"$row"]}" | cut -d' ' -f"$column")
			plaintext+="$decoded_letter"
		done
		echo "$plaintext"
	;;
esac





