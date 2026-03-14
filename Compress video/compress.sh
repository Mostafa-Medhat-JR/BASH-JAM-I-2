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

compress(){
echo -e "Do you want to compress a file [${blue}1${reset}] or a folder [${blue}2${reset}]?"
read -p "Enter your choice: " choice
[[ "$choice" = "exit" ]] && exit_program


case "$choice" in

    1)while true; do
            read -p "Enter full path of the video file: " path
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
    ;;

    2) while true; do
        read -p "Enter full folder path: " folder_path
        [[ "$folder_path" = "exit" ]] && exit_program

        if [[ -d "$folder_path" ]]; then
            if find "$folder_path" -type f \( -iname ".mp4" -o -iname ".mkv" -o -iname ".avi" -o -iname ".mov" \) | grep -q .; then
                break
            else
                echo "No video files found in this folder"
            fi
        else
            echo "Invalid folder"
        fi
    done
    ;;

esac

echo "--------------------"
while true; do
    echo "The smaller the number → Better quality & Larger size"
    echo "The larger the number → Lower quality & Smaller size"
    read -p "Enter compression level (18-35, default 23): " level
    [[ "$level" = "exit" ]] && exit_program

    if [[ -z "$level" ]]; then
        level=23
        break
    fi

    if ! [[ "$level" =~ ^[0-9]+$ ]]; then
        echo "Invalid input: please enter numbers only"
        continue
    fi

    if [[ "$level" -ge 18 && "$level" -le 35 ]]; then
        break
    else
        echo "Invalid level: must be between 18 and 35"
    fi
done

echo "--------------------"
while true; do

  echo "New Path [1]"
  echo "The same path [2]"
  read -p "Enter your choice: " new
  [[ "$new" = "exit" ]] && exit_program
  echo "------------------"
  if [[ "$new" = "1" ]]; then
      while true; do
    read -p "Enter new full path: " newpath
    [[ "$newpath" = "exit" ]] && exit_program

    if [[ -z "$newpath" ]]; then
        echo -e "${red}Path cannot be empty${reset}"
        continue
    fi

    if [[ -d "$newpath" ]]; then
        break
    else
        echo -e "${red}This path does not exist${reset}"
    fi
done

      break
  elif [[ "$new" = "2" ]]; then
      read -p "Are you sure (y/n)? " confirm
      [[ "$confirm" = "exit" ]] && exit_program
      if [[ "$confirm" = "y" || "$confirm" = "Y" ]]; then
          break
      else
          echo "Operation cancelled"
      fi
  else
      echo "Invalid choice"
  fi
done

if [[ "$choice" = "1" ]]; then
    if [[ "$new" = "1" ]]; then
	    read -p "$(echo -e "${red}Do you want to change the filename for ${f##*/}? (y/n): ${reset}")" change_name
        if [[ "$change_name" = "y" ]]; then
            read -p "Enter new filename (with extension): " newname
            output="$newpath/$newname"
        else
            filename=$(basename "$path")
            output="$newpath/${filename%.}_compressed.${filename##.}"
        fi
    else
        read -p "$(echo -e "${red}Do you want to change the filename for ${f##*/}? (y/n): ${reset}")" change_name
        if [[ "$change_name" = "y" ]]; then
            read -p "Enter new filename (with extension ,newname.mp4): " newname
            dir=$(dirname "$path")
            output="$dir/$newname"
        else
            filename=$(basename "$path")
            dir=$(dirname "$path")
            output="$dir/${filename%.}_compressed.${filename##.}"
        fi
    fi
    ffmpeg -i "$path" -vcodec libx264 -crf "$level" "$output"
    echo "Video compressed to: $output"

elif [[ "$choice" = "2" ]]; then
    for f in "$folder_path"/*.{mp4,mkv,avi,mov}; do
        [[ ! -f "$f" ]] && continue
        if [[ "$new" = "1" ]]; then
            read -p "$(echo -e "${red}Do you want to change the filename for ${f##*/}? (y/n): ${reset}")" change_name
            if [[ "$change_name" = "y" ]]; then
                read -p "Enter new filename (with extension, newname.mp4): " newname
                output="$newpath/$newname"
            else
                filename=$(basename "$f")
                output="$newpath/${filename%.}_compressed.${filename##.}"
            fi
        else
            read -p "Do you want to change the filename for ${f##*/}? (y/n): " change_name
            if [[ "$change_name" = "y" ]]; then
                read -p "Enter new filename (with extension): " newname
                dir=$(dirname "$f")
                output="$dir/$newname"
            else
                filename=$(basename "$f")
                dir=$(dirname "$f")
                output="$dir/${filename%.}_compressed.${filename##.}"
            fi
        fi
        ffmpeg -i "$f" -vcodec libx264 -crf "$level" "$output"
        echo -e "${green}Compressed: $output ${reset}"
    done
fi


}

echo -e "${green}----------------Welcome-------------${reset}"
echo "---------------------------------------------"
echo -e "${red}---You can type \"exit\" at any time to exit---${reset}"
echo "--------------------------"

compress
