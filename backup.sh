#!/bin/bash

# Define variables for restic backup

pwfile="/path/to/password"
target="restic repo location" # example: sftp:ab1234@ab1234.rsync.net:/data1/home/ab1234/restic-repo
basedir="/path/to/directory"

/usr/local/bin/restic -p "$pwfile" -r "$target" backup --tag warc-chk "$basedir"/warc-chk
/usr/local/bin/restic -p "$pwfile" -r "$target" forget --keep-last 1 --prune --tag warc-chk
