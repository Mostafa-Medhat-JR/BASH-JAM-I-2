#!/bin/bash
## Ansi color code variables
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

words=("linux" "ubuntu" "debian" "fedora" "pop" "linuxmint" "osc" "command" "echo" "computer" "kernel" "script" "terminal")
random=$((RANDOM % ${#words[@]}))
word=${words[$random]}
wordlen=${#word}

echo -e "${bold}${blue}-----One wrong character, one step closer to the gallows. Can you break the silence of the strings?-----${reset}"
echo "--------------------------------------------------------------------------------------------"

wrong=0
display=""

for (( i=0; i<wordlen; i++ )); do
   display+="*"
done

hangman() {
    case $1 in
        0) echo -e "  +---+\n  |   |\n      |\n      |\n      |\n      |\n=========" ;;
        1) echo -e "  +---+\n  |   |\n  O   |\n      |\n      |\n      |\n=========" ;;
        2) echo -e "  +---+\n  |   |\n  O   |\n  |   |\n      |\n      |\n=========" ;;
        3) echo -e "  +---+\n  |   |\n  O   |\n /|   |\n      |\n      |\n=========" ;;
        4) echo -e "  +---+\n  |   |\n  O   |\n /|\\  |\n      |\n      |\n=========" ;;
        5) echo -e "  +---+\n  |   |\n  O   |\n /|\\  |\n /    |\n      |\n=========" ;;
        6) echo -e "  +---+\n  |   |\n  O   |\n /|\\  |\n / \\  |\n      💀\n=========" ;;
    esac
}
echo -e "${red}The length of the word is :  $wordlen ${reset}"
while true; do
    echo -e "\n${blue}Guess the word: ${bold}$display${reset}"
    hangman $wrong

    if [[ "$display" == "$word" ]]; then
        echo -e "${green}${bold}WINNER! You saved him!${reset}"
        break
    fi

    if (( wrong == 6 )); then
    echo -e "${red}${bold}GAME OVER! The word was: $word${reset}"
    break
    fi

    read -p "Pick your letter: " letter
    if [[ ! $letter =~ ^[a-z]$ ]]; then
        echo -e "${red}Please enter a single small letter${reset}"
        continue
    fi

    if [[ "$word" == *"$letter"* ]]; then
        new_display=""
        for (( i=0; i<wordlen; i++ )); do
            if [[ "${word:$i:1}" == "$letter" ]]; then
                new_display+="$letter"
            else
                new_display+="${display:$i:1}"
            fi
        done
        display=$new_display
    else
        ((wrong++))
    fi
done
 
