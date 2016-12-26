FROM deevus/plex-remote-transcoder:base-public
MAINTAINER Simon Hartcher <github.com/deevus>

RUN apt-get install openssh-client -qy

COPY root/ /

VOLUME /ssh
