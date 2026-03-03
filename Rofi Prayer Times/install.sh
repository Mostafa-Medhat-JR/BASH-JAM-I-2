#!/bin/bash

set -e

INSTALL_DIR="$HOME/.local/share/prayer-times"
BIN_DIR="$HOME/.local/bin"

mkdir -p "$INSTALL_DIR" "$BIN_DIR"

cp prayer_times.sh "$INSTALL_DIR/"
cp prayer_times_style.css "$INSTALL_DIR/"

chmod +x "$INSTALL_DIR/prayer_times.sh"

ln -sf "$INSTALL_DIR/prayer-times.sh" "$BIN_DIR/prayer-times"

echo "Installed successfully!"
echo "Bind prayer-times to a keyboard shortcut"
