#! /bin/bash
# Requires dunst for notifications.

cd $HOME

DEST=/media/share0/Backups/linux/home/
archive="$DEST${USER}-home-backup-$(date +%F-%s).tar.gz"

EXCLUDE_DIR=( --exclude="$archive" --exclude=".cache" --exclude="Dropbox" --exclude="VirtualBox VMs" )

check_space() {
    free_space=$(df $DEST --output=avail | sed -n '2p');
    archive_max_space=$(du -s "${EXCLUDE_DIR[@]}" | grep -P -o '\d+\s');
    if [[ $(($free_space - $archive_max_space)) -gt 0 ]]; then
       return 0;
   else
       return 1;
    fi
}

backup() {
    dunstify "BACKING UP" "/home/${USER}..."
    tar -cvpzf "$archive" "${EXCLUDE_DIR[@]}" --one-file-system $HOME
    dunstify ".../home/${USER} backed up as"  "$archive"
}

if check_space 
then
    backup;
else
    dunstify "HOME BACKUP FAILED" "Probably not enough space...";
fi
