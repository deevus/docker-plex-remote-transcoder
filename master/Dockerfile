FROM plexinc/pms-docker:plexpass
MAINTAINER Simon Hartcher <github.com/deevus>

RUN apt-get update -q && \
    apt-get install unzip python-setuptools openssh-client -qy

COPY root/ /

VOLUME /ssh
