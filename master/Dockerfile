FROM deevus/plex-remote-transcoder:base-latest
MAINTAINER Simon Hartcher <github.com/deevus>

RUN apt-get install openssh-client -qy

COPY root/ /

VOLUME /ssh
