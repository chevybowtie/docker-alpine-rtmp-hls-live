### Purpose

This docker container will setup an `nginx` web server that supports `rtmp` and `http` protocols. The idea is a quick way to get OBS streaming to your own, private server where you can control who sees the boradcast.

It exposes `port 80` for `http://` viewing and `port 1935` for `rtmp` ingesting (it also relays back out on 1935). Few clients understand `rtmp` so most of your viewers/listeners would be hitting the `http://` broadcast. (`https://` is planned).

### Broadcast site

For video broadcast, a 1080p stream takes between 2-5Mbs. Your site should have, at minimum, 8Mbs of upload bandwidth. The benefit of using this container is that if you have 10 people watching, then you'd need closer to 30Mbs to keep those streams going. Using this container, you can use your upload bandwidth more efficiently - this container will stream to the 10 user while you only have to worry with a single 3Mbs stream.


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
 d2ce170cb21b        rtmp-hls-live       "/usr/bin/supervisor…"   29 seconds ago      Up 27 seconds       80/tcp, 1935/tcp   

$ docker stop d2ce170cb21b
```

### 2. Setup OBS to push a stream to container

OBS should be setup to stream to `rtmp://{domainname or IP}/live/`.  Whatever you wish the `{room-name}` to be should be entered for in the `{stream-key}` field.

In other words, the `{stream-key}` becomes the `{room-name}` in your addresses.

* rtmp://{domainname or IP}/live/{room-name} 

`{room-name}` can be anything you choose when you start the stream. It must be unique among all active streams being pushed to this container.


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

