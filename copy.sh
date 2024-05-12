#!/bin/bash

# Define the path
basedir="/path/to/directory"

last_checked=$(cat "$basedir"/last_checked.txt)
username=$(echo "$last_checked" | grep -oP '(?<=user-)[A-Za-z0-9_]+')

destination="$basedir/warch-chk/$username"
mkdir -p "$destination"

rsync -ah --stats "$basedir/working/*" "$destination"
echo Finished copying to "$destination"
