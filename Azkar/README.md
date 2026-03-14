# Azkar Notification Script

A Bash script that displays Islamic Azkar (remembrances) as desktop notifications at regular intervals.  
It fetches daily morning and evening Azkar from a remote JSON file.

## Features

- Fetches Azkar from a remote JSON API (`Islamic-Api`)  
- Shows desktop notifications using `notify-send`  
- Automatically distinguishes between morning and evening Azkar based on system time  
- Randomly selects Azkar from different categories:  
  - الاستغفار و التوبة  
  - التشهد  
  - الصلاة على النبي بعد التشهد  
  - فضل الصلاة على النبي صلى الله عليه و سلم  
  - التسبيح، التحميد، التهليل، التكبير 

-The script can automatically detect your Linux distro and prompt to install missing dependencies.

-Supported many package managers
## How to Run

1. Give execution permission (first time only):
chmod +x Ziker_Reminder.sh
2. ./Ziker_Reminder.sh
