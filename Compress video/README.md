# Video Compression Script

A Bash script that compresses video files (MP4, MKV, AVI, MOV) either from a single file or an entire folder.  
The script uses `ffmpeg` to compress videos and allows optional renaming and saving to a new folder.

## Features

- Compress a single video file or all videos in a folder
- Adjustable compression level (CRF 18–35)
- Option to rename output files
- Option to save compressed files to a new folder or the same folder
- Automatically detects Linux distribution and installs `ffmpeg` if missing
- Supports multiple Linux distributions: Ubuntu, Debian, Fedora, CentOS, Arch, Alpine, openSUSE, etc.

### How to Run

1. Give execution permission (first time only):
chmod +x compress.sh

2. ./compress.sh
