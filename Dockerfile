# Alpine Linux 3.6
FROM golang:alpine
MAINTAINER kawin <kawinv@zercle.technology>

ARG	timezone=Asia/Bangkok
ENV	TERM xterm

ENV	LANG en_US.UTF-8
ENV	LC_ALL en_US.UTF-8
ENV	TZ $timezone

# Add config repositories
RUN	echo 'http://dl-cdn.alpinelinux.org/alpine/v3.6/main' > /etc/apk/repositories \
	&& echo 'http://dl-cdn.alpinelinux.org/alpine/v3.6/community' >> /etc/apk/repositories \
	&& echo '@edge http://dl-cdn.alpinelinux.org/alpine/edge/main' >> /etc/apk/repositories \
	&& echo '@testing http://dl-cdn.alpinelinux.org/alpine/edge/testing' >> /etc/apk/repositories \
	&& mkdir /run/openrc \
	&& touch /run/openrc/softlevel

# Add basic package 
RUN	apk update && apk upgrade \
	&& apk add --no-cache \
		openrc \
		libressl \
		wget \
		curl \
		git \
		nano \
		openssh \
		htop \
		bash \
		bash-completion \
		tzdata \
		pwgen

# Change timezone
RUN	echo $timezone > /etc/timezone \
	&& cp /usr/share/zoneinfo/$timezone /etc/localtime

# Change shell
RUN	sed -i "s|:ash|:bash|" /etc/passwd

# Clean file
RUN	rm -rf /var/cache/apk/*
