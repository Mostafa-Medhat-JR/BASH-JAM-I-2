# Prayer Times Menu (Wofi)

## Definition
This is a simple wofi menu that displays prayer times for the user based on their location from an api with their ip

## Work flow

### adds a custom config file for wofi and makes sure it exists, then declares method variable for calculating prayer times (method 3 -> Muslim World League's method).

caches the fetched coords from ip to avoid api abuse (constantly asking for it) and uses them from cache if they exist.
reads ip from `https://ipapi.co/json/` and pipes it to jq to fetch only longitude and latitude parts (used to calc times and qibla).
minor error handling if lat and lon aren't numerical values.

### Qibla direction calculation:
Mekkah's coords are hard coded for ease then uses initial compass bearing (azimuth) between two points on a sphere (Mekkah and fetched coords) to calculate an approximate direction of prayer ((WIP)) using `awk` tool.

### Time handling
#### clean_time():
first cleans strings and outputs them in hh:mm format using regex to get only numerics and colons as aladhan api can return some unwanted values (in this script) like utc.
#### tosecond():
then turns time into seconds from midnight (for ease of calculation) by multiplyng every thing before the `:` (hours) by 3600 and everything after (mins) by 60.
#### calculate_countdown():
finally actually calcs time by converting time now (`date` in bash) to seconds also then calcs difference between them and echos it in a human readable format (/ 3600 for hrs, % 3600 * 60 for mins, % for secs).

### fetch_prayer_times():
uses curl tool twice to fetch ip and times from api `https://api.aladhan.com/v1/timings`.

### build_menu():
fetches then writes in timings variable, then loops in a day's 5 prayers and adds items in it.
checks if time is more than time now to decide if it's passed or not to display countdown (static remaining time until next prayer).

## Install
./install.sh

## GNOME Shortcut
Settings → Keyboard → Custom Shortcuts
Command: prayer-times

## Requirements
- bash
- curl
- jq
- wofi
- awk

## Dependencies

### Ubuntu / Debian
sudo apt install curl jq wofi

### Arch
sudo pacman -S curl jq wofi

### Fedora
sudo dnf install curl jq wofi
