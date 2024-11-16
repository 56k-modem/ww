#!/bin/bash
# temp comment
# Define base directory
basedir="/path/to/directory"

warcdir="$basedir/warc"
workdir="$basedir/working"

mkdir -p "$workdir"

process_warc() {
    local warcfile="$1"
    echo "Processing $warcfile"
    echo "Last checked: $warcfile" > $HOME/last_checked.txt
    python3 -m warcat extract "$warcfile" --output-dir "$warcdir" --progress
    local num_files=$(find "$warcdir" -type f -name "*_fs.jpg" | wc -l)
    if [ "$num_files" -gt 0 ]; then
        find "$warcdir" -type f -name "*_fs.jpg" -exec mv -v "{}" "$workdir/" \; | awk -F "'" '{print $2}'
        rm -f "$warcfile"
        echo "Done processing $warcfile"
        echo "$num_files files found."
        declare -A year_counts
        for jpgfile in "$workdir"/*.jpg; do
            year=$(date -r "$jpgfile" "+%Y")
            ((year_counts["$year"]++))
        done
        for year in "${!year_counts[@]}"; do
            echo "$year: ${year_counts[$year]}"
        done | sort
        unset year_counts
        unset jpgfile
        return 0
    else
        echo "No files found for processing."
        rm -f "$warcfile"
        echo "Done processing $warcfile"
        return 1
    fi
}

for warcfile in "$warcdir"/*.warc.gz; do
    if process_warc "$warcfile"; then
        read -p "[Enter] to process the next warc archive"
        rm -rf "$workdir"/*
        echo "Working directory emptied."
    fi
done

echo "No more warc archives found."

# Cleanup
rm -rf "$warcdir"/*
echo "Cleanup completed."
