Build this:
```
$ apt-get install git 
$ git clone https://github.com/chevybowtie/docker-alpine-rtmp-hls-live.git
$ cd docker-alpine-rtmp-hls-live/
$ docker-compose up -d
```


### 2. Run the container
```
docker run -ti --restart=always --name rtmp -p 80:80 -p 1935:1935 -v /mydata/hls:/var/tmp/hls -d alpine-rtmp   
```

### 3. Default push-stream address

#### rtmp://host ip/live/live-room number (can be filled in at will, can't conflict)


### 4. Default playback address

#### rtmp://Host ip/live/room no.

#### http://主机ip/live/房间号.m3u8   

#### http://主机ip/live/房间号_1080p.m3u8 （1080p分辨率）   

#### http://主机ip/live/房间号_720p.m3u8 （720p分辨率）   

#### http://主机ip/live/房间号_480p.m3u8 （480p分辨率）   
