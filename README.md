Build this:
```
$ apt-get install git 
$ git clone https://github.com/chevybowtie/docker-alpine-rtmp-hls-live.git
$ cd docker-alpine-rtmp-hls-live/
$ docker build -t rtmp-hls-live .
$ docker image ls
REPOSITORY          TAG                 IMAGE ID            CREATED             SIZE
rtmp-hls-live       latest              38926b571df9        5 days ago          106MB
$ docker run -d rtmp-hls-live
$ docker container ls
CONTAINER ID        IMAGE               COMMAND                  CREATED             STATUS              PORTS               NAMES
d2ce170cb21b        rtmp-hls-live       "/usr/bin/supervisor…"   29 seconds ago      Up 27 seconds       80/tcp, 1935/tcp    nostalgic_meninsky
$ docker stop d2ce170cb21b
$
```

### 2. Default push-stream address

#### rtmp://host ip/live/{room#} (can be filled in at will, can't conflict)


### 3. Default playback address

* rtmp://Host ip/live/{room#}
* http://Host ip/live/{room#}.m3u8   
* http://Host ip/live/{room#}_1080p.m3u8 （1080p Resolution）   
* http://Host ip/live/{room#}_720p.m3u8 （720p Resolution）   
* http://Host ip/live/{room#}_480p.m3u8 （480p Resolution）   


### 4. Alter image
```
docker run -i -t rtmp-hls-live /bin/sh
fetch http://dl-cdn.alpinelinux.org/alpine/v3.10/main/x86_64/APKINDEX.tar.gz
fetch http://dl-cdn.alpinelinux.org/alpine/v3.10/community/x86_64/APKINDEX.tar.gz
(1/2) Installing libmagic (5.37-r1)
(2/2) Installing nano (4.3-r0)
Executing busybox-1.30.1-r3.trigger
OK: 119 MiB in 74 packages
```
