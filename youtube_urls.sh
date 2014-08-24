#!/usr/bin/env bash

# Scrape YouTube urls from a webpage, open as playlist in VLC
# For example when reading forum threads or imageboards with lots of links

if [ "$#" -ne 1 ]; then
    echo "Usage: $0 url"
    exit
fi

curl -s $1 | html2text | grep -Eo "http.*youtu.*\s?" | sort -u | xargs vlc > /dev/null 2>&1 &
