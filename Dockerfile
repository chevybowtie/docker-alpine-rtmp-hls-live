FROM alpine:latest
MAINTAINER Paul Sturm <chevybowtie@thesturms.com>

# include local static files
ADD ./static /var/www/static
RUN chmod 755 /var/www/static/ -v

# update software

RUN apk update
RUN apk upgrade

# install nano
RUN apk add nano



### install nginx

# we are going to compile some sources so we need these...
# RUN apk add git
# RUN apk add build-base
# RUN apk add zlib zlib-dev
# RUN apk add perl
# RUN apk add alpine-sdk

# install nginx from repo
RUN apk add nginx

# install rtmp plugin
RUN apk add nginx-mod-rtmp

# install cert-bot for nginx so we may use SSL later on...
RUN apk add certbot-nginx


# clone rtmp-module from source
# RUN git clone https://github.com/sergey-dryabzhinsky/nginx-rtmp-module.git

# compile nginx from source using nginx-rtmp-module
# RUN wget https://www.openssl.org/source/openssl-1.1.1d.tar.gz
# RUN tar -xf openssl-1.1.1d.tar.gz
# RUN rm openssl-1.1.1d.tar.gz

# RUN wget https://nginx.org/download/nginx-1.17.7.tar.gz
# RUN tar -xf nginx-1.17.7.tar.gz
# RUN rm nginx-1.17.7.tar.gz

# WORKDIR "/nginx-1.17.7" 
# RUN ls -lha 
# RUN ./configure --with-http_ssl_module --add-module=../nginx-rtmp-module --without-http_rewrite_module --with-openssl=../openssl-1.1.1d 
# RUN make 
# RUN make install





### install supervisor

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
