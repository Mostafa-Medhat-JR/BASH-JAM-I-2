#!/bin/bash

# Ansi color code variables
red="\e[0;91m"
blue="\e[0;94m"
expand_bg="\e[K"
blue_bg="\e[0;104m${expand_bg}"
red_bg="\e[0;101m${expand_bg}"
green_bg="\e[0;102m${expand_bg}"
green="\e[0;92m"
white="\e[0;97m"
bold="\e[1m"
uline="\e[4m"
reset="\e[0m"

echo -e "${blue}${bold}--------Welcome to you in Lucky Guess--------${reset}"
echo "Game description: The ability to guess/reach the number in the fewest attempts"
count=0
read -p "First enter your name : " name
value=$(((RANDOM % 1000) +1 ))
echo -e "${blue}${bold}The laptop chose a value from 1 to 1000 .... try to guess it${reset}"

while true; do
       read -p "Enter your guess : " guess
       if [[ ! $guess =~ ^[0-9]+$ ]]; then
	     echo -e "${red}invlaid , please input only number${reset}"
	     continue
       fi
       if (( $guess < 1 || $guess > 1000 )); then
             echo -e "${red}invalid ,the number from 1 to 1000${reset}"
             continue
       fi

       ((count++))
       if [[ "$guess" == "$value" ]]; then
              echo -e "${green}"
              echo "   \\ \\_/ / |  | | |  | |  \\ \\  /\\  / /  | | |  \\| |"
              echo "    \\   /| |  | | |  | |   \\ \\/  \\/ /   | | | . \\ |"
              echo "     | | | |_| | || |    \\  /\\  /   _| || |\\  |"
              echo "     ||  \\_/ \\_/      \\/  \\/   |_|| \\_|"
              echo -e "${blod} Winner Winner Mabrook $name! You got it in $count tries${reset}"
              break
       else 
	echo -e "${red}Wrong ,try again${reset}"
	if [[ "$guess" > "$value" ]]; then
		echo "The value is smaller than your guess"
	elif [[ "$guess" < "$value" ]]; then
		 echo "The value is bigger than your guess"
	fi
	echo -e "${blue}${bold}----------------------------------${reset}"
       fi
done


