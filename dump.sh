#!/usr/bin/env bash

# dump.sh: dump a list of files or directories to a remove destination

#            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
#                    Version 2, December 2004
#
# Copyright (C) 2004 Sam Hocevar <sam@hocevar.net>
#
# Everyone is permitted to copy and distribute verbatim or modified
# copies of this license document, and changing it is allowed as long
# as the name is changed.
#
#            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
#   TERMS AND CONDITIONS FOR COPYING, DISTRIBUTION AND MODIFICATION
#
#  0. You just DO WHAT THE FUCK YOU WANT TO.

REMOTE_DIR=""
CHMOD=""
i=0

if [ -f $HOME/.dumprc ]; then
    # add dump config, e.g:
    # REMOTE_HOST="domain.com"
    # REMOTE_PATH="/var/www/dump/"
    # REMOTE_URL="http://dump.domain.com"
    # CHMOD="--chmod=Du=rwx,Dg=rx,Do=rx,Fu=rw,Fg=r,Fo=r"
    source $HOME/.dumprc
fi

HELPMSG="
Usage:\t`basename $0` [-h] [-c PERMISSIONS] [-d REMOTE_DIR] [FILES..]\n
\t-c\tspecify permissions for --chmod option in rsync\n
\t-d\tput files in specified remote directory, create if it does not exist\n
\t-h\tshow help and exit\n
"

if [ `expr $# - $i` -lt 1 ]; then
    echo -e $HELPMSG
    exit 1
fi

while getopts hd:c: opt; do
    case $opt in
        c)  CHMOD="--chmod=$OPTARG"
            let i++ ;;
        d)  REMOTE_DIR="$OPTARG"
            if [ "${REMOTE_DIR: -1}" != '/' ]; then
                REMOTE_DIR="$REMOTE_DIR"/
            fi
            let i++ ;;
        h)  echo -e $HELPMSG
            exit 1 ;;
    esac
    let i++
done

rsync -Prazq $CHMOD --rsync-path="mkdir -p \"$REMOTE_PATH$REMOTE_DIR\" && rsync" \
    "${@: -$#+$i}" "$REMOTE_HOST":"'$REMOTE_PATH$REMOTE_DIR'"

for var in "${@: -$#+$i}"; do
    REMOTE_DIR=$(echo "$REMOTE_DIR" | sed -e 's/ /%20/g')
    file=$(basename "$var" | sed -e 's/ /%20/g')
    echo "URL: $REMOTE_URL$REMOTE_DIR$file"
done

exit 0

