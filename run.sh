#!/bin/bash

function symlink {
    egrep -o '(rsync|ftp|https?)://[^ ]+' < /etc/apt/mirror.list | while  IFS= read -r line; do
        url=${line/http:\/\//''}
        IFS='/' read -r -a parseName <<< "$url"
        final_path=$WEBROOT${parseName[-1]}
        if [ ! -h "$final_path" ]; then
            ln -s "/var/spool/apt-mirror/mirror/$url" "$final_path"
        fi
    done
}

service apache2 start

custom_mirror_list=true
if [ ! -e /etc/apt/mirror.list ]; then
    printf "No custom mirror.list file detected, using default at %s\n" "$MIRROR"
    ln -s /opt/mirror.list /etc/apt/mirror.list
    sed -i "s|http://archive.ubuntu.com/ubuntu|$MIRROR|g" /etc/apt/mirror.list
    symlink
    custom_mirror_list=false
fi

while true; do
    if [ "$custom_mirror_list" ]; then
        symlink
    fi
    printf "\nInitializing apt-mirror ... \n"
    /usr/bin/apt-mirror
    echo "{ \"lastSync\": \"$(date -u +'%Y-%m-%dT%H:%M:%SZ')\" }" > $WEBROOT/healthcheck.json
    printf  "\nCompleted! Apt mirror sync will run again in %s\n" "$SYNC_TIME"
    sleep "$SYNC_TIME"
done
