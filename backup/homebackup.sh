#! /bin/bash
# Requires dunst for notifications.

# Change to the user's home directory
cd "$HOME"

# Destination directory for the backup
DEST="/media/share0/Backups/linux/home/"
# Define the archive name with the user's name, date, and seconds since epoch
archive="${DEST}${USER}-home-backup-$(date +%F-%s).tar.gz"

# Directories to exclude from backup
EXCLUDE_DIR=( --exclude="$archive" --exclude=".cache" --exclude="Dropbox" --exclude="VirtualBox VMs" )

# Function to check if there is enough space for backup
check_space() {
    # Get available space on the destination disk
    free_space=$(df "$DEST" --output=avail | sed -n '2p')
    # Calculate the maximum space needed for the backup
    archive_max_space=$(du -s "${EXCLUDE_DIR[@]}" | grep -P -o '\d+\s')
    # Check if there is enough free space
    if [[ $(($free_space - $archive_max_space)) -gt 0 ]]; then
       return 0;  # Enough space
   else
       return 1;  # Not enough space
    fi
}

# Function to perform the backup
backup() {
    # Notify the user that the backup is in progress
    dunstify "BACKING UP" "/home/${USER}..."
    # Create the tar archive, excluding specified directories
    tar -cvpzf "$archive" "${EXCLUDE_DIR[@]}" --one-file-system "$HOME"
    # Notify the user that the backup is complete
    dunstify ".../home/${USER} backed up as"  "$archive"
}

# Check if there is enough space before initiating the backup
if check_space 
then
    # Perform the backup if there is enough space
    backup
else
    # Notify the user if the backup failed due to insufficient space
    dunstify "HOME BACKUP FAILED" "Probably not enough space..."
fi
