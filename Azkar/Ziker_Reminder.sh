#!/bin/bash

exit_program() {
    echo "Exiting program..."
    exit 0
}

Determine_package_manager() {
    if [ -f /etc/os-release ]; then
        . /etc/os-release
        distro=$ID

        if [[ "$distro" == "ubuntu" || "$distro" == "debian" || "$distro" == "linuxmint" || "$distro" == "pop" ]]; then
            pkg="apt"
        elif [[ "$distro" == "fedora" ]]; then
            pkg="dnf"
        elif [[ "$distro" == "rhel" || "$distro" == "centos" ]]; then
            pkg="dnf"
        elif [[ "$distro" == "opensuse-leap" || "$distro" == "opensuse-tumbleweed" ]]; then
            pkg="zypper"
        elif [[ "$distro" == "manjaro" || "$distro" == "arch" ]]; then
            pkg="pacman"
        elif [[ "$distro" == "alpine" ]]; then
            pkg="apk"
        else
            echo "Unknown distro, install manually"
            exit 1
        fi
    else
        echo "Cannot detect distribution"
        exit 1
    fi
}

Determine_package_manager

commands=(curl jq notify-send)
packages=()

if [[ "$pkg" == "apt" ]]; then
    packages=(curl jq libnotify-bin)
elif [[ "$pkg" == "pacman" ]]; then
    packages=(curl jq libnotify tk)
elif [[ "$pkg" == "dnf" || "$pkg" == "zypper" || "$pkg" == "apk" ]]; then
    packages=(curl jq libnotify)
fi

for i in "${!commands[@]}"; do
    cmd="${commands[$i]}"
    pkgname="${packages[$i]}"

        if ! command -v "$cmd" >/dev/null 2>&1; then
            echo "$pkgname is not installed"
            read -p "Do you want to install $pkgname? (y/n/exit): " install
            [ "$install" == "exit" ] && exit_program

            if [[ "$install" == "y" || "$install" == "Y" ]]; then
                case "$pkg" in
                    apt)
                        sudo apt update
                        sudo apt install -y "$pkgname"
                        ;;
                    dnf)
                        sudo dnf install -y "$pkgname"
                        ;;
                    zypper)
                        sudo zypper install -y "$pkgname"
                        ;;
                    pacman)
                        sudo pacman -Sy --noconfirm "$pkgname"
                        ;;
                    apk)
                        sudo apk add "$pkgname"
                        ;;
                esac
            fi
        fi
done

url="https://raw.githubusercontent.com/itsSamBz/Islamic-Api/refs/heads/main/adkar.json"
jsonfile="$HOME/zikr.json"
waiting=300

fjson(){
    curl -s "$url" -o "$jsonfile"
    if [[ ! -s "$jsonfile" ]]; then
        exit 1
    fi
}

[[ ! -f "$jsonfile" ]] && fjson

while true; do
    ctime=$(date +"%H")
    ctime=$((10#$ctime))

    category=("الاستغفار و التوبة" "التشهد" "الصلاة على النبي بعد التشهد" "فضل الصلاة على النبي صلى الله عليه و سلم" "التسبيح، التحميد، التهليل، التكبير")

    if (( ctime < 12 )); then
        category=("أذكار الصباح" "${category[@]}")
    else
        category=("أذكار المساء" "${category[@]}")
    fi

    cate=$(printf "%s\n" "${category[@]}" | shuf -n 1)
    zikr=$(jq -r --arg cat "$cate" '.[] | select(.category == $cat) | .text' "$jsonfile" | shuf -n 1)
    notify-send -u critical -t 0 -a "Azkar" -i face-smile -w "$cate" "$zikr"
    sleep "$waiting"
done
