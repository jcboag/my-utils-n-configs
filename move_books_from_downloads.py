#! /usr/bin/python3

import sys, os, shutil

filename, ext = os.path.splitext(sys.argv[1])

BOOKS = '/media/share0/Books'

EXT_DIR = {'.epub': BOOKS, '.pdf': BOOKS}

if ext in EXT_DIR and os.path.isdir(EXT_DIR[ext]):
    shutil.move(filename + ext, EXT_DIR[ext])
