#!/bin/bash

# Default number of entries to display
DEFAULT_ENTRIES=8

# Parse command line arguments
while getopts ":dn:" opt; do
    case $opt in
        d )
            list_all=true
            ;;
        n )
            num_entries=$OPTARG
            ;;
        \? )
            echo "Invalid option: $OPTARG is not a valid option" 1>&2
            exit 1
            ;;
    esac
done
shift $((OPTIND - 1))

# Set default number of entries if not specified
if [ -z "$num_entries" ]; then
    num_entries=$DEFAULT_ENTRIES
fi

# Get directory to check
directory=$1

# Check if directory argument is specified
if [ -z "$directory" ]; then
    echo "Usage: $0 [-d] [-n num_entries] directory" 1>&2
    exit 1
fi

# Check if directory exists
if [ ! -d "$directory" ]; then
    echo "Error: $directory does not exist" 1>&2
    exit 1
fi

#Display disk usage
if [ "$list_all" = true ]; then
    du -ah $directory | sort -rh
else
    du -h $directory | sort -rh | head -n $num_entries
fi