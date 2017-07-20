FROM plexinc/pms-docker:latest
MAINTAINER Simon Hartcher <github.com/deevus>

RUN apt-get update -q && \
    apt-get install unzip python-setuptools python-psutil openssh-client -qy

ENV SLAVE_IP=slave_ip \
    SLAVE_PORT=22 \
    SLAVE_USER=plex \
    MASTER_IP=master_ip

COPY root/ /

VOLUME /ssh
