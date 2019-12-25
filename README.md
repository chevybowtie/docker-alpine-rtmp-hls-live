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
