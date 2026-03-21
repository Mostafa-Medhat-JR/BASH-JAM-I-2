#!/bin/bash

distroList=("fedora" "arch" "mint" "kali" "opensuse" "debian" "endeavouros" "ubuntu" "popos" "redhat")

descripDistroList=(
"Fedora – Cutting-edge, developer-focused Linux.\n"
"Arch – Minimal, powerful, build-it-yourself distro.\n"
"Mint – Beginner-friendly and Windows-like.\n"
"Kali – Cybersecurity and penetration testing distro.\n"
"openSUSE – Stable, flexible, and professional-grade.\n"
"Debian – Ultra-stable and rock-solid foundation.\n"
"EndeavourOS – Lightweight, close-to-Arch experience.\n"
"Ubuntu – Popular, beginner-friendly with huge community support.\n"
"Pop!_OS – Ubuntu-based, optimized for performance and developers.\n"
"Red Hat – Enterprise-grade Linux used in servers and businesses.\n"
)

dirDistroPath="./DistrosImages/"

numOfRightDistros=0

while true
do
    choice=$(( RANDOM % 10 ))

    shuffled=($(shuf -i 0-9))

    options=( )


    for ((i=0; i<10; i++))
    do
        options+=("$((i+1))" "${distroList[${shuffled[$i]}]}")
    done


    xdg-open "$dirDistroPath/${choice}.webp" &
    sleep 2


    answer=$(zenity \
        --list \
        --title="Guess the Linux Distro" \
        --text="Which distro is this?" \
        --column="No." --column="Distro" \
        "${options[@]}" \
        --width=900 --height=1000)


    if [[ -z "$answer" ]]
    then
       pkill -f "${choice}.webp"
      break
      fi


    selectedanswer=$(( --answer ))

    if [[ "${shuffled[$selectedanswer]}" -eq "$choice" ]]
    then
        zenity --info --text="you Gussed right the distro is  ${distroList[$choice]}  "
       zenity --info --text="${descripDistroList[$choice]}" --width=500 --height=800
       pkill -f "${choice}.webp"
       sleep 1
        ((numOfRightDistros++))

    else

        zenity --info --text="wrong Guess"
        pkill -f "${choice}.webp"
        sleep 1
    fi

done
zenity --info --text="${descripDistroList[$choice]}" --width=500 --height=800
zenity --info --text="\t\t\tGame Over! \nYou got $numOfRightDistros correct."