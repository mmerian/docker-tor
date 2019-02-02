# Docker tor image

## Volumes
There are two declared volumes :
* `/usr/local/etc/tor`, which contains the torrc file used by the tor process
* `/var/lib/tor`, which is where the tor process stores its data

## Running
`docker pull mmerian/docker-tor`

`docker run -d -v <local-etc-dir>:/usr/local/etc/tor -v <local-data-dir>:/var/lib/tor mmerian/docker-tor`
