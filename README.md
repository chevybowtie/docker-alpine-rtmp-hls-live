### Purpose

This docker container will setup an `nginx` web server that supports `rtmp` and `http` protocols. The idea is a quick way to get OBS streaming to your own, private server where you can control who sees the boradcast.


### 1. Build from this repo:
```
$ apt-get install git 

$ git clone https://github.com/chevybowtie/docker-alpine-rtmp-hls-live.git

$ cd docker-alpine-rtmp-hls-live/

$ docker build -t rtmp-hls-live .

$ docker image ls
 REPOSITORY          TAG                 IMAGE ID            CREATED             SIZE
 rtmp-hls-live       latest              38926b571df9        5 days ago          106MB

$ docker run -p 80:80 -p 1935:1935 -d rtmp-hls-live

$ docker container ls
 CONTAINER ID        IMAGE               COMMAND                  CREATED             STATUS              PORTS               NAMES
 d2ce170cb21b        rtmp-hls-live       "/usr/bin/supervisor…"   29 seconds ago      Up 27 seconds       80/tcp, 1935/tcp    nostalgic_meninsky

$ docker stop d2ce170cb21b
```

### 2. Setup OBS to push-stream to container

OBS should be setup to stream to `rtmp://{domainname or IP}/live/`.  Whatever you wish the `{room-name}` to be should be entered for in the `{stream-key}` field.

In other words, the `{stream-key}` becomes the `{room-name}` in your addresses.

[OBS Setting](data:image/png;base64, data:image/png;base64,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)

* rtmp://{domainname or IP}/live/{room-name} 

`{room-name}` can be anything you choose when you start the stream. It must be unique for all active streams.


### 3. Default playback address

* rtmp://{domainname or IP}/live/{room-name}
* http://{domainname or IP}/live/{room-name}.m3u8   
* http://{domainname or IP}/live/{room-name}_1080p.m3u8 （1080p Resolution）   
* http://{domainname or IP}/live/{room-name}_720p.m3u8  （720p Resolution）   
* http://{domainname or IP}/live/{room-name}_480p.m3u8  （480p Resolution）   


### 4. Use the shell in a container

This is not really useful since it discards anything you do, but it helped me understand containers and their life-cycle more.

```
$ docker run -i -t rtmp-hls-live /bin/sh

/ # apk add --no-cache nano

fetch http://dl-cdn.alpinelinux.org/alpine/v3.10/main/x86_64/APKINDEX.tar.gz
fetch http://dl-cdn.alpinelinux.org/alpine/v3.10/community/x86_64/APKINDEX.tar.gz
(1/2) Installing libmagic (5.37-r1)
(2/2) Installing nano (4.3-r0)
Executing busybox-1.30.1-r3.trigger
OK: 119 MiB in 74 packages
```

### TODO

These are planned items

* enable HTTPS by passing in a domain name to the container - Let's Encrypt will create our cert for us
* web site: 
  * request user input of how many listeners are using a stream
  * report - stats on stream quality, number of listeners
  * add /stats/ page to the web server so you can view the statistics of the streams being processed
* add security (right now you can only restrict by IP addresses before you start the container)
* add instructions to upload to a plesk server or AWS Fargate
* add a trivial API to retrieve the container build version
* allow storage and retrieval of streams for 2 weeks
* allow audio only for low bandwidth broadcast sites


### Alternate way to get this running

If you're not interested in building your own container, [a docker image](https://hub.docker.com/repository/docker/chevybowtie/media-rebroadcast) is available so you can get the end result. These are automatically built from the master branch when the master branch is tagged with a new version.

