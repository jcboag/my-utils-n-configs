#! /bin/python3

import os
import shutil
import subprocess
import re
import time
import datetime

# Set source and destination directories
SRC_DIR = os.environ['HOME']
BACKUPS_DIR = os.path.expandvars("$HOME/backups")

# Maximum number of backups to keep
MAX_BACKUPS = 5

# Create archive name with timestamp
ARCHIVE_NAME = '{}/{}-home-backup-{}-{}.tar.gz'.format(
    BACKUPS_DIR, os.environ['USER'], str(datetime.date.today()), int(time.time())
)

# Directories to exclude from backup
EXCLUDE_FILES = ["VirtualBox VMs", "Dropbox", ".cache", ".steam", ".ghcup"]

# Function to get the size of a directory
def get_directory_size(directory):
    # regex to capture size in bytes from output
    size_regx = re.compile('^(\d+)')
    # run du on the directory
    output = subprocess.run(["du", directory, "-s"], capture_output=True, text=True).stdout
    return int(size_regx.match(output).group(1))

# Function to check if there is enough space for backup
def enough_space():
    file_system_space = shutil.disk_usage(BACKUPS_DIR).free
    src_space = get_directory_size(SRC_DIR)
    return (file_system_space - src_space > 0)

# Function to extract timestamp from archive filename
def extract_timestamp(filename):
    timestamp = re.compile(r'.*-([0-9]+)\.tar\.gz$')
    return int(timestamp.match(filename).group(1))

# Function to build exclude options for tar command
def build_exclude(file_list):
    return ["--exclude={}".format(d) for d in file_list]

# Function to perform the backup
def backup():
    print("BACKING UP TO  " + BACKUPS_DIR + "...")
    os.chdir(BACKUPS_DIR)
    process = subprocess.Popen(
        ["tar", "-cvpzf", ARCHIVE_NAME]
        + build_exclude(EXCLUDE_FILES)
        + [SRC_DIR]
        + ["--one-file-system"],
        text=True,
        stdout=subprocess.PIPE,
        stderr=subprocess.PIPE  # Capture stderr for more comprehensive error handling
    )
    while True:
        output = process.stdout.readline()
        if not output and process.poll() is not None:
            break
        if output:
            print(output.strip())
    print("RETURN CODE: {}".format(process.poll()))

# Function to handle backup failure
def fail():
    print("Something went wrong. Did not backup")

# Main function
def main():
    # get all archives from backups directory
    prev_backups = [
        os.path.join(BACKUPS_DIR, f)
        for f in filter(lambda f: os.path.splitext(f)[1] == '.gz', os.listdir(BACKUPS_DIR))
    ]
    # Remove oldest backup if backup directory is full (wrt to MAX_BACKUPS)
    if len(prev_backups) >= MAX_BACKUPS:
        prev_backups.sort(reverse=True, key=extract_timestamp)
        os.remove(prev_backups.pop())
    if enough_space():
        backup()
    else:
        fail()

# Entry point of the script
if __name__ == '__main__':
    main()
