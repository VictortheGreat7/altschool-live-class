#!/bin/bash

# Parse the command line arguments
if [ "$#" -ne 2 ]; then
    echo "Usage: $0 source_directory destination_directory" >&2
    exit 1
fi

source_directory=$1
destination_directory=$2

# Check if the source directory exists
if [ ! -d "$source_directory" ]; then
    echo "Error: Source directory '$source_directory' does not exist" >&2
    exit 1
fi

# Check if the destination directory exists, if not, ask for permission to create it
if [ ! -d "$destination_directory" ]; then
    echo "Destination directory '$destination_directory' does not exist."
    read -p "Do you want to create '$destination_directory' ? [Y/n] " choice
    case "$choice" in
      y|Y )
        mkdir -p "$destination_directory" || exit 1
        echo "Directory '$destination_directory' created."
        ;;
      n|N )
        echo "Operation canceled by user."
        exit 1
        ;;
      * )
        echo "Invalid choice." >&2
        exit 1
        ;;
    esac
fi

# Check if the destination directory is writable
if [ ! -w "$destination_directory" ]; then
    echo "Error: Destination directory '$destination_directory' is not writable" >&2
    exit 1
fi

# Create backup with timestamp
timestamp=$(date +%Y-%m-%d_%H-%M-%S)
backup_filename="backup_$timestamp.tar.gz"
tar -czf "$destination_directory/$backup_filename" -C "$source_directory" .
if [ $? -ne 0 ]; then
    echo "Error: Failed to create backup" >&2
    exit 1
fi

echo "Backup created: $destination_directory/$backup_filename"