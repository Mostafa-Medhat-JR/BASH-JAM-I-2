#!/bin/bash

# Make an array of the directories in the root directory (if a visible non-directory exists in the root directory this part breaks)
dirs=()
for dir in */; do
    dir=${dir%/}

    if [ "$(find "$dir" -maxdepth 1 -type f | wc -l)" -gt 0 ]; then
        dirs+=("$dir")
    fi
done

# Choose a random directory from the array dirs
randDir=${dirs[$(($RANDOM % ${#dirs[@]}))]}

files=()

for file in $(ls $randDir); do
    files=("${files[@]}" "$file")
done

randFile=${files[$(($RANDOM % ${#files[@]}))]}

mpv --geometry=480x480 $randDir/$randFile

echo "$randDir"
echo "$randFile"
