#!/bin/bash

################################# Variables Declaration Section #################################
greenbold="\033[1;32m"
normal="\033[0m"

################################# Functions Declaration Section #################################
function asking {
	read -p "$1" num 
	echo $num
}

function wait {
	echo -en "$1 " 
	read dummy
}
function line {
	echo "-------------------------------------------------------------"
}
function converstion {
	num=$1
	base=$2
	while [[ $num -gt $((base-1)) ]]; do
		dividend=$(( num / base ))
		rem=$(( num % base ))
		num=$dividend
		case $rem in
			10)	rem=A;;
			11)	rem=B;;
			12)	rem=C;;
			13) rem=D;;
			14) rem=E;;
			15) rem=F;;
		esac
		reminder+="$rem"
	done
	reminder+="$num"
	length=${#reminder}
	for ((count=length-1 ; count >= 0; count--)); do
		item+=${reminder:count:1}
	done
	echo $item
}

function checkNum {
	num=$1
	base=$2
	status=0
	length=${#num}

	for ((count = 0; count < length; count++)); do
		digit=${num:count:1}
		case $digit in
			A|a)		digit=10;;
			B|b)		digit=11;;
			C|c)		digit=12;;
			D|d)		digit=13;;
			E|e)		digit=14;;
			F|f)		digit=15;;
			[G-Zg-z])	digit=17;;
			*)			digit=$digit;;
		esac
		if [[ $digit -ge $base ]]; then
			status=1
			break
		fi
	done
	echo $status
}

function reversion {
	num=$1
	base=$2
	length=${#num}
	basecount=$((length-1))
	result=0
	for ((count = 0; count < length; count++)); do
		digit=${num:count:1}
		case $digit in
			A|a)	digit=10;;
			B|b)	digit=11;;
			C|c)	digit=12;;
			D|d)	digit=13;;
			E|e)	digit=14;;
			F|f)	digit=15;;
			*)		digit=$digit;;
		esac
		expbase=$((base**basecount))
		((result+=digit*expbase))
		((basecount--))
	done
	echo $result
}
##################################### Main Program Section ######################################
while true; do
	clear
	echo -e $greenbold"\n\t\tMain Menu"$normal
	echo -e "\nSelect your choice from below:-"
	echo -e "\n\t(1) Decimal to Binary Number"
	echo -e "\t(2) Binary to Decimal Number"
	echo -e "\t(3) Decimal to Octal Number"
	echo -e "\t(4) Octal to Decimal Number"
	echo -e "\t(5) Decimal to Hexadecimal Number"
	echo -e "\t(6) Hexadecimal to Decimal Number"
	echo -e "\t(7) Exit"
	echo -en "\nEnter your choice [1-7]: " 
	read choice

	case $choice in
		1|2)	num=2; system=Binary;;
		3|4)	num=8; system=Octal;;
		5|6)	num=16; system=Hexadecimal;;
	esac
	case $choice in
		1|3|5)
			line
			dec=$(asking "Enter a Decimal Number : ")
			# Calling converstion function for converstion
			conNum=$(converstion "$dec" "$num")
			line
			echo -e $greenbold"Converstion"$normal
			echo "$dec = $conNum"
			line
			wait $greenbold"Press <ENTER> to continue..."$normal
			;;
		2|4|6)
			while true; do
				line
				conNum=$(asking "Enter a $system Number : ")
				result=$(checkNum "$conNum" "$num")
				if [[ $result -eq 1 ]]; then
					line
					echo "Please enter a valid $system number"
				else
					break
				fi
			done
			dec=$(reversion "$conNum" "$num")
			line
			echo -e $greenbold"Converstion"$normal
			echo "$conNum = $dec"
			line
			wait $greenbold"Press <ENTER> to continue..."$normal
			;;
		7)
			clear
			echo -e "\n\nAllah Haifz\n\n"
			break
			;;
		*)	
			line
			wait $greenbold"Wrong selection, Press <ENTER> to continue..."$normal
			;;
	esac
done
