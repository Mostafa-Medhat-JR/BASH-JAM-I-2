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

#--exit--
exit_program() {
    echo "Exiting program..."
    exit 0
}


Determine_package_manager() {

if [[ -f /etc/os-release ]]; then
    . /etc/os-release
    distro=$ID
    echo "Detected distro: $distro"

    if [[ "$distro" = "ubuntu" || "$distro" = "debian" || "$distro" = "linuxmint" || "$distro" = "pop" ]]; then
       sudo apt update
       sudo apt install ffmpeg -y

    elif [[ "$distro" = "fedora" ]]; then
       sudo dnf install ffmpeg ffmpeg-devel -y

    elif [[ "$distro" = "rhel" || "$distro" = "centos" ]]; then
       sudo dnf install epel-release -y
       sudo dnf install ffmpeg ffmpeg-devel -y

    elif [[ "$distro" = "opensuse-leap" || "$distro" = "opensuse-tumbleweed" ]]; then
        sudo zypper refresh
        sudo zypper install ffmpeg -y

    elif [[ "$distro" = "manjaro" || "$distro" = "arch" ]]; then
        sudo pacman -Syu --noconfirm ffmpeg

    elif [[ "$distro" = "alpine" ]]; then
        sudo apk update
        sudo apk add ffmpeg
    fi

else
    echo "The type of distribution was not specified"
    echo "Install the ffmpeg manually"
    exit 1
fi
}

tool="ffmpeg"

if ! command -v "$tool" >/dev/null 2>&1; then
    echo "ffmpeg is not installed"
    read -p "Do you want to install it? (y|n): " install_tool
    [[ "$install_tool" = "exit" ]] && exit_program

    if [[ "$install_tool" = "y" || "$install_tool" = "Y" ]]; then
        echo "Installing ffmpeg..."
        Determine_package_manager
    fi

fi
extract(){

echo "Do you want to extract from file[1] or folder[2]"
read -p "Enter your choice" choice
[[ "$choice" = "exit" ]] && exit_program

case "$choice" in
    1)while true; do
        read -p "Enter your full path of file" path
        [[ "$path" = "exit" ]] && exit_program
        if [[ -f "$path" ]]; then
            case "$path" in
                .mp4|.mkv|.avi|.mov)
                    break
                    ;;
                *)
                    echo "File is not a video"
                    ;;
            esac
        else
            echo "Invalid path"
        fi
    done
    echo "Extract to new folder[1] or same folder[2]"
    read -p "Enter your choice" create
    [[ "$create" = "exit" ]] && exit_program
            if [[ "$create" = "1" ]]; then
            while true; do
        read -p "Enter your new path" new    
        [[ "$new" = "exit" ]] && exit_program
        if [[ -d "$new" ]]; then
            break
        else
            echo "This path does not exit"
        fi
    done
    filename=$(basename "$path")
    name="${filename%.*}"
    output="$new/${name}_audio.mp3"

       else 
           filename=$(basename "$path")
           name="${filename%.*}"
           diname=$(dirname "$path")
           output="$diname/${name}_audio.mp3"
    fi
        read -p "Do you want to change the filename? (y/n): " rename
        if [[ "$rename" = "y" || "$rename" = "Y" ]]; then
        read -p "Enter new filename (with extension, newname.mp3): " newname
        output_dir=$(dirname "$output")
        output="$output_dir/$newname"
    fi

    ffmpeg -i "$path" -q:a 0 -map a "$output"
    echo "Done Extract"
    ;;

     2)while true; do
         read -p "Enter your folder path" fpath
         [[ "$fpath" = "exit" ]] && exit_program
         if [[ -d "$fpath" ]]; then
             if find "$fpath" -type f \( -iname ".mp4" -o -iname ".mkv" -o -iname ".avi" -o -iname ".mov" \) | grep -q .; then
                break
        else
            echo "No videos file found in this folder"
         fi
     else
         echo "invalid folder"
         fi
     done

     echo "Extract to new folder[1] or same folder[2]"
     read -p "Enter your choice" createf
     [[ "$createf" = "exit" ]] && exit_program

     if [[ "$createf" = "1" ]]; then
         while true; do
            read -p "Enter new path" newpathf
            [[ "$newpathf" = "exit" ]] && exit_program
            if [[ -d "$newpathf" ]]; then
                break
            else
                echo "this path not exit"
            fi
        done
     fi

    for i in "$fpath"/*.{mp4,mkv,avi,mov}; do
        [[ ! -f "$i" ]] && continue
        filename=$(basename "$i")
        name="${filename%.*}"
        if [[ "$createf" = "1" ]];then
        output="$newpathf/${name}_audio.mp3"
    else
        dif=$(dirname "$i")
        output="$dif/${name}_audio.mp3"
        fi
        read -p "Do you want to rename '$filename'? (y/n): " rename
            if [[ "$rename" = "y" || "$rename" = "Y" ]]; then
                read -p "Enter new filename (with extension): " newname
                if [[ "$createf" = "1" ]]; then
                    output="$newpathf/$newname"
                else
                dir=$(dirname "$i")
                output="$dir/$newname"
               fi
        else
            if [[ "$createf" = "1" ]]; then
                output="$newpathf/${name}_audio.mp3"
            else
                dir=$(dirname "$i")
                output="$dir/${name}_audio.mp3"
            fi
        fi
        ffmpeg -i "$i" -q:a 0 -map a "$output"
        echo "Done"
    done
    ;;
 *)
     echo "Invalid choice"
     ;;
esac
}

echo -e "${green}----------------Welcome-------------${reset}"
echo "---------------------------------------------"
echo -e "${red}---You can type \"exit\" at any time to exit---${reset}"
echo "--------------------------"
extract
