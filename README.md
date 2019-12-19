Build this:
```
$ apt-get install git 
$ git clone https://github.com/chevybowtie/docker-alpine-rtmp-hls-live.git
$ cd docker-alpine-rtmp-hls-live/
$ docker-compose up -d
```


### 2.运行容器   
```
docker run -ti --restart=always --name rtmp -p 80:80 -p 1935:1935 -v /mydata/hls:/var/tmp/hls -d alpine-rtmp   
```

### 3.默认推流地址   

#### rtmp://主机ip/live/直播房间号(可随便填写，不能冲突)   


### 4.默认播放地址   

#### rtmp://主机ip/live/房间号   

#### http://主机ip/live/房间号.m3u8   

#### http://主机ip/live/房间号_1080p.m3u8 （1080p分辨率）   

#### http://主机ip/live/房间号_720p.m3u8 （720p分辨率）   

#### http://主机ip/live/房间号_480p.m3u8 （480p分辨率）   
