#!/bin/bash

# Define the base directory
BASE_DIR="/Library/Application Support/Enexis"

# Define the target directories
PICTURES_DIR="$BASE_DIR/Pictures"
PACKAGES_DIR="$BASE_DIR/Packages"
SCRIPTS_DIR="$BASE_DIR/Scripts"
LOGS_DIR="$BASE_DIR/Logs"

# Define the URL to download the file
FILE_URL="https://dev.azure.com/ENX-WPL/12456404-0439-4ea9-85c2-7f079cb5d4e3/_apis/git/repositories/e5ea4662-6cac-4c40-900d-57018fbf05a6/items?path=/Baseline/pictures/logos/logo.png&versionDescriptor%5BversionOptions%5D=0&versionDescriptor%5BversionType%5D=0&versionDescriptor%5Bversion%5D=main&resolveLfs=true&%24format=octetStream&api-version=5.0"

# Define the target file path
TARGET_FILE="$PICTURES_DIR/Logo.png"

# Create the "Application Support" directory if it doesn't exist (optional, normally exists)
if [ ! -d "/Library/Application Support/Enexis" ]; then
    echo "Creating /Library/Application Support/Enexis directory"
    sudo mkdir -p "/Library/Application Support/Enexis"
fi

# Create the base directory if it doesn't exist
if [ ! -d "$BASE_DIR" ]; then
    echo "Creating base directory: $BASE_DIR"
    sudo mkdir -p "$BASE_DIR"
fi

# Create the target directories if they don't exist
for DIR in "$PICTURES_DIR" "$PACKAGES_DIR" "$SCRIPTS_DIR" "$LOGS_DIR"; do
    if [ ! -d "$DIR" ]; then
        echo "Creating directory: $DIR"
        sudo mkdir -p "$DIR"
    fi
done

# Make the base directory hidden
echo "Hiding the base directory: $BASE_DIR"
sudo chflags hidden "$BASE_DIR"

# Download the file into the Pictures directory
echo "Downloading file from $FILE_URL to $TARGET_FILE"
sudo curl -L -o "$TARGET_FILE" "$FILE_URL"

# Check if the download was successful
if [ $? -eq 0 ]; then
    echo "File downloaded successfully to $TARGET_FILE"
else
    echo "Failed to download file"
    exit 1
fi
