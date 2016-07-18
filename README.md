# apt-mirror

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