#!/bin/bash

# Define the file to be modified
FILE="/etc/fish/config.fish"

# Define the line to be appended
LINE='# Modified by me\n\nset -g fish_greeting\nsource (/usr/bin/starship init fish --print-full-init | psub)'

# Append the line to the file
echo -e "$LINE" >> "$FILE"

# Print a message indicating the line was appended
echo "Line appended to $FILE"
