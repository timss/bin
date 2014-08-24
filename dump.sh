#!/usr/bin/env bash

# Wrapper around rsync for easy uploading of files from shell
# to be used with for example Apache directory listing

if [ $# -lt 1 ]; then
    echo -e "\033[1;37mUsage: \033[0;37mdump \033[0;34mfile \033[0;36m[destination]"
    exit 1
fi

file=$1
filename=$(basename $1)
dest=${2#\/}

if [ ! -f $file ]; then
    echo -e "\033[0;31mCould not find: \033[0;33m$file"
    exit 1
fi

if [ -z "$dest" ]; then
    dest="tmp"
fi

rsync -aqP --chmod=a=rw,g=r,o=r -e ssh $file user@host:/var/www/dump/$dest

if [ $? != 0 ]; then
    echo -e "\033[0;31mError during upload."
    echo -e "\033[1;30m-------------------"
    echo -e "\033[0;33m$!"
    exit 1
fi

echo -e "\033[1;30m---------------"
echo -e "\033[1;37mDone uploading: \033[0;36m$filename"
echo -e "\033[1;37mLink:           \033[0;34mhttp://host.com/dump/${dest%\/}/$filename"

exit 0
