FROM debian:latest
MAINTAINER Graham Lee <ghmlee@ghmlee.com>

RUN apt-get update && apt-get -y upgrade && apt-get install -y git-core python-dev
RUN git clone https://github.com/letsencrypt/letsencrypt /usr/src/letsencrypt

WORKDIR /usr/src/letsencrypt

RUN ./letsencrypt-auto --help