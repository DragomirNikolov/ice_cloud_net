#!/usr/bin/env bash
set -euo pipefail

if [ $# -lt 1 ]; then
    echo "Usage: $0 <directory-path>"
    exit 1
fi

dir_path=$1
search_string="NA-20"

cd "$dir_path"

find . -maxdepth 1 -type f -name "*${search_string}*.zip" -print0 |
xargs -0 -n 1 -P 12 bash -c '
    zip_file="$1"
    unzip -oq "$zip_file" && rm -f "$zip_file"
    echo "Unzipped and deleted: $zip_file"
' _ 