#!/bin/bash


SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DB_PATH="$SCRIPT_DIR/database.txt"

if [ ! -f "$DB_PATH" ]; then
    notify-send "Error" "Database file not found at: $DB_PATH"
    exit 1
fi

RANDOM_HADITH=$(shuf -n 1 "$DB_PATH")
FORMATTED_HADITH=$(echo "$RANDOM_HADITH" | tr '*' '\n' )

echo -e "$FORMATTED_HADITH" | rofi -dmenu -p "قال رسول اللَّه ﷺ : " -theme ~/.config/rofi/launchers/type-2/style-1.rasi -theme-str 'configuration { rtl: true; } window {  width: 60%; height: 0; } listview { lines: 4; dynamic: true; fixed-height: false;} element { padding: 10px 20px; } element-text { horizontal-align: 0.5; vertical-align: 0.5; multi-line: true; wrap: true; font: "Amiri 20"; line-spacing: 0; line-style: "word"; }
  inputbar { enabled: false; }'> /dev/null 2>&1

notify-send "‏" "$FORMATTED_HADITH"
