#!/usr/bin/env bash

source "$HOME"/.config/ml4w/library.sh

# Get script folder
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
echo ":: Script Directory: $SCRIPT_DIR"

# --- Script Initialization and Argument Handling ---
DRY_RUN_FLAG=""
# Check if the first parameter is -n or --dry-run
if [[ "$3" == "-n" || "$3" == "--dry-run" ]]; then
    DRY_RUN_FLAG="-n"
    _writeLog ":: DRY RUN MODE ACTIVE"
fi

SOURCE_DIR=${1:-"/home/talto/.mydotfiles/com.ml4w.kenose-dotfiles.dev/.config"}
TARGET_DIR=${2:-"/home/talto/workspace/com.ml4w.kenose-dotfiles/dotfiles/.config"}

# Configuration
if [ ! -d "$SOURCE_DIR" ]; then
    _writeLog ":: Error: Source directory argument invalid ($SOURCE_DIR)"
    exit 1
fi
if [ ! -d "$TARGET_DIR" ]; then
    _writeLog ":: Error: Target directory argument invalid ($TARGET_DIR)"
    exit 1
fi

# EVENTS="modify,create,delete,move"
EVENTS="modify,create"
EXCLUDE_FILE="$SCRIPT_DIR/protected.txt"

echo ":: Source: $SOURCE_DIR"
echo ":: Target: $TARGET_DIR"
echo
echo ":: Starting Folder Sync Daemon"

# --- Daemon Loop ---

# Daemon will only run if NOT in dry-run mode, but the sync logic is tested
while true; do
    echo ":: Waiting for changes in $SOURCE_DIR..."
    
    # Wait for file system events
    inotifywait -r -e "$EVENTS" --quiet "$SOURCE_DIR"
    
    # Debounce period
    sleep 1 
    
    echo ":: Change detected! Running sync now..."
    
    # Construct the base rsync command flags
    RSYNC_CMD="rsync -azv --delete --exclude=config.dotinst $DRY_RUN_FLAG"

    # Add the exclude-from option if the file exists
    if [ -f "$EXCLUDE_FILE" ]; then
        echo ":: Protected file list ($EXCLUDE_FILE) detected and will be used."
        RSYNC_CMD="$RSYNC_CMD --exclude-from=\"$EXCLUDE_FILE\""
    fi

    if [ -n "$DRY_RUN_FLAG" ]; then
        echo :: rsync command: $RSYNC_CMD "$SOURCE_DIR/" "$TARGET_DIR"
        echo
    fi

    # Execute the final rsync command
    eval $RSYNC_CMD "$SOURCE_DIR/" "$TARGET_DIR"

    if [ -n "$DRY_RUN_FLAG" ]; then
        echo
        echo ":: DRY RUN COMPLETE. No changes were made to $TARGET_DIR."
        echo ":: You can exit the script with CTRL+C"
    fi
    echo
    echo ":: Sync successful. Returning to monitor mode."
done

exit 0