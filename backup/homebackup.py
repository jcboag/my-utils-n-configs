#! /bin/python3

import os, shutil, subprocess
import re
import tarfile
import time
import datetime

SRC_DIR = os.environ['HOME']
BACKUPS_DIR = "$HOME/backups"
MAX_BACKUPS = 5
ARCHIVE_NAME = '{}/{}-home-backup-{}-{}.tar.gz'.format(BACKUPS_DIR, os.environ['USER'],str(datetime.date.today()),int(time.time()))
EXCLUDE_FILES = ["VirtualBox VMs", "Dropbox", ".cache", ".steam", ".ghcup"]

def get_directory_size(directory):
    # regex to capture size in bytes from output
    size_regx = re.compile('^(\d+)')
    # run du on the directory
    output = subprocess.run(["du", directory, "-s"],capture_output=True,text=True).stdout
    return int(size_regx.match(output).group(1))

def enough_space():
    file_system_space = shutil.disk_usage(BACKUPS_DIR)[2]
    src_space = get_directory_size(SRC_DIR)
    return (file_system_space - src_space > 0)

def extract_timestamp(filename):
    timestamp = re.compile(r'.*-([0-9]+)\.tar\.gz$')
    return int(timestamp.match(filename).group(1))

def build_exclude(file_list):
    return [ "--exclude={}".format(d) for d in file_list ]

def backup():
    print ("BACKING UP TO  " + BACKUPS_DIR + "...")
    os.chdir(BACKUPS_DIR)
    process = subprocess.Popen(["tar", "-cvpzf" , ARCHIVE_NAME] \
                          + build_exclude(EXCLUDE_FILES) \
                          + [SRC_DIR] \
                          + ["--one-file-system"],
                          text=True,
                          stdout=subprocess.PIPE)
    while True:
        output = process.stdout.readline()
        if not output and process.poll() is not None:
            break
        if output:
            print(output.strip())
    print("RETURN CODE: {}".format(process.poll()))

def fail():
    print("Something went wrong. Did not backup")

def main():
    # get all archives from backups directory
    prev_backups = list(map(lambda f: os.path.join(BACKUPS_DIR, f), filter(lambda f: os.path.splitext(f)[1] == '.gz', os.listdir(BACKUPS_DIR))))
    # Remove oldest backup if backup directory full (wrt to MAX_BACKUPS)
    if len(prev_backups) >= MAX_BACKUPS:
        prev_backups.sort(reverse=True,key=extract_timestamp)
        os.remove(prev_backups.pop())
    if enough_space():
        backup()
    else:
        fail()

if __name__ == '__main__':
    main()
