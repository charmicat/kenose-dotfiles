#!/usr/bin/env bash

source "$HOME"/.config/ml4w/library.sh


# Get script folder
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
echo "Script Directory: $SCRIPT_DIR"

_SOURCE_DIR=""
_TARGET_DIR=""
# --- Script Initialization and Argument Handling ---
DRY_RUN_FLAG=""
while getopts "s:t:n" opt; do
  case $opt in
    n)
      _writeLog "DRY RUN MODE ACTIVE"
      DRY_RUN_FLAG="-n"
      ;;
    s)
      _SOURCE_DIR="$OPTARG"
      ;;
    t)
      _TARGET_DIR="$OPTARG"
      ;;
    \?)
      echo "Invalid option: -$OPTARG" >&2
      ;;
  esac
done


SOURCE_DIR=${_SOURCE_DIR:-"/home/talto/.mydotfiles/com.ml4w.kenose-dotfiles.dev/.config"}
TARGET_DIR=${_TARGET_DIR:-"/home/talto/workspace/com.ml4w.kenose-dotfiles/dotfiles/.config"}

if [ -f "$SOURCE_DIR/.sync_running" ]; then
    _writeLog "Another sync process is already running for source directory: $SOURCE_DIR"
    _writeLog "Exiting to prevent conflicts."
    exit 1
fi

# Configuration
if [ ! -d "$SOURCE_DIR" ]; then
    _writeLog "Error: Source directory argument invalid ($SOURCE_DIR)"
    exit 1
fi
if [ ! -d "$TARGET_DIR" ]; then
    _writeLog "Error: Target directory argument invalid ($TARGET_DIR)"
    exit 1
fi

# EVENTS="modify,create,delete,move"
EVENTS="modify,create,moved_to"
EXCLUDE_FILE="$SCRIPT_DIR/protected.txt"

_writeLog "Source: $SOURCE_DIR"
_writeLog "Target: $TARGET_DIR"
echo
_writeLog "Starting Folder Sync Daemon"

# --- Daemon Loop ---

# Daemon will only run if NOT in dry-run mode, but the sync logic is tested
while true; do
    _writeLog "Waiting for changes in $SOURCE_DIR..."
    
    # Wait for file system events
    inotifywait -r -e "$EVENTS" --quiet "$SOURCE_DIR"
    
    # Debounce period
    sleep 1 
    
    _writeLog "Change detected! Running sync now..."
    
    # Construct the base rsync command flags
    RSYNC_CMD="rsync -azv --delete --exclude=config.dotinst $DRY_RUN_FLAG"

    # Add the exclude-from option if the file exists
    if [ -f "$EXCLUDE_FILE" ]; then
        _writeLog "Protected file list ($EXCLUDE_FILE) detected and will be used."
        RSYNC_CMD="$RSYNC_CMD --exclude-from=\"$EXCLUDE_FILE\""
    fi

    if [ -n "$DRY_RUN_FLAG" ]; then
        _writeLog rsync command: "$RSYNC_CMD" "$SOURCE_DIR/" "$TARGET_DIR"
        echo
    fi

    # Execute the final rsync command
    eval $RSYNC_CMD "$SOURCE_DIR/" "$TARGET_DIR"

    if [ -n "$DRY_RUN_FLAG" ]; then
        echo
        _writeLog "DRY RUN COMPLETE. No changes were made to $TARGET_DIR."
        _writeLog "You can exit the script with CTRL+C"
    fi
    echo
    _writeLog "Sync successful. Returning to monitor mode."
done

exit 0