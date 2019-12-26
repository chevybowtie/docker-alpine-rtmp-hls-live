Build from this repo:
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
