#!/bin/bash

#set source_dir as current dir
source_dir=$(pwd)
dest_dir=$source_dir
#get dest_dir from user
read -p "welcome to file organizer! press enter to start "
echo "organizing your files .."
sleep 3

img_path="$dest_dir/Images"
docs_path="$dest_dir/Documents"
media_path="$dest_dir/Media"
others_path="$dest_dir/Other"

# create new dirs for docs images, media , others
mkdir -p   "$img_path"
mkdir -p "$docs_path"
mkdir -p  "$media_path"
mkdir -p "$others_path"

# sorting logic
find "$source_dir" -maxdepth 1 -type f \( -iname "*.jpg" -o -iname "*.png" \) -exec  mv {} "$img_path" \;
find "$source_dir" -maxdepth 1 -type f \( -iname "*.pdf" -o -iname "*.txt" -o -iname "*.docx" \) -exec mv {} "$docs_path" \;
find "$source_dir" -maxdepth 1 -type f \( -iname "*.mp3" -o -iname "*.mp4" -o -iname "*.mov" \) -exec mv {} "$media_path" \;
#find "$source_dir" -maxdepth 1 -type f !-name "organize.sh" -exec mv {} "$others_path" \;

echo "your files have been organized!"


