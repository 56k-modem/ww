#!/bin/bash

# Define the path where the .tar archive will be downloaded
basedir="/path/to/directory"

mkdir -p "$basedir"
aria2c -c --file-allocation=none --dir="$basedir" -x 10 -s 10 $1

# Define the ntfy.sh topic to get an alert about the completed download
topic="topic"

curl -d "aria2 exited" ntfy.sh/"$topic"
