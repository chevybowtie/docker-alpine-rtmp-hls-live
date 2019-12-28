FROM alpine:latest

MAINTAINER Paul Sturm <paul.sturm@cotton-software.com>

# include local static files
COPY ./static /var/www/static
RUN chmod 755 /var/www/static/ -v
RUN ls -lha /var/www/static/

# update software

RUN apk update
RUN apk upgrade

# install nano

RUN apk add nano




### install web server stuff

# install nginx from repo
RUN apk add nginx

# install rtmp plugin
RUN apk add nginx-mod-rtmp

# install cert-bot for nginx so we may use SSL later on...
RUN apk add certbot-nginx




### install supervisor

RUN apk add supervisor




### install ffmpeg and aac plugin

RUN apk add ffmpeg faac




### copy configururation files

## nginx conf
COPY ./nginx/nginx.conf /etc/nginx/nginx.conf

## supervisor conf
COPY ./supervisor/supervisord.conf /etc/supervisor/supervisord.conf
COPY ./supervisor/conf.d/supervisord.conf /etc/supervisor/conf.d/supervisord.conf




### create needs folder and permission

RUN mkdir -p /var/live/hls
RUN chmod 755 /var/live/hls/ -v

RUN mkdir -p /var/log/supervisor

RUN mkdir -p /run/nginx

# forward request and error logs to docker log collector

RUN ln -sf /dev/stdout /var/log/nginx/access.log \
	&& ln -sf /dev/stderr /var/log/nginx/error.log

# The essence of cache is to reuse, for example, multiple containers 
# can mount the same cached file system without repeatedly downloading it 
# from the network so I've chosen not to use `apk add --no-cache`
# 
# this will remove the package cache that we have no use for now

RUN rm /var/cache/apk/*




### run container

EXPOSE 80 1935

# CMD ["/usr/bin/supervisord","-c","/etc/supervisor/supervisord.conf"]
CMD ["/usr/sbin/nginx"]
