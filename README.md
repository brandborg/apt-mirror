# apt-mirror

[![Docker Stars](https://img.shields.io/docker/stars/gmitre/apt-mirror.svg)](https://hub.docker.com/r/gmitre/apt-mirror/)
[![Docker Pulls](https://img.shields.io/docker/pulls/gmitre/apt-mirror.svg)](https://hub.docker.com/r/gmitre/apt-mirror/) [![](https://images.microbadger.com/badges/image/gmitre/apt-mirror.svg)](https://microbadger.com/images/gmitre/apt-mirror "Get your own image badge on microbadger.com")

## How to run ?

```
$ docker run -p 80:80 -v /data/mirror:/var/spool/apt-mirror gmitre/apt-mirror
```

## Available environment variables

`MIRROR=http://archive.ubuntu.com/ubuntu`
`SYNC_TIME=24h`
`WEBROOT=/var/www/apt/`


## Available mount points
`/var/spool/apt-mirror`
`/etc/apt/mirror.list` 