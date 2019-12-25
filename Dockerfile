FROM alpine:latest
MAINTAINER Paul Sturm <chevybowtie@thesturms.com>

# use china souce
# ADD ./apk/repositories /etc/apk/repositories

# include local static files
ADD ./static /var/www/static
RUN chmod 755 /var/www/static/ -v

# update software

RUN apk update
RUN apk upgrade

# install nano
#RUN apk add nano

# install nginx

RUN apk add nginx

# install rtmp plugin

RUN apk add nginx-mod-rtmp

# install supervisor

RUN apk add supervisor

# copy configure file

## nginx conf
ADD ./nginx/nginx.conf /etc/nginx/nginx.conf

## supervisor conf
ADD ./supervisor/supervisord.conf /etc/supervisor/supervisord.conf
ADD ./supervisor/conf.d/supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# install ffmpeg and aac plugin

RUN apk add ffmpeg faac

# create needs folder and permission

RUN mkdir -p /var/live/hls
RUN chmod 755 /var/live/hls/ -v

RUN mkdir -p /var/log/supervisor

RUN mkdir -p /run/nginx

# forward request and error logs to docker log collector
RUN ln -sf /dev/stdout /var/log/nginx/access.log \
	&& ln -sf /dev/stderr /var/log/nginx/error.log


# run container

EXPOSE 80 1935

CMD ["/usr/bin/supervisord","-c","/etc/supervisor/supervisord.conf"]

