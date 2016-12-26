FROM plexinc/pms-docker:latest
MAINTAINER Simon Hartcher <github.com/deevus>

RUN apt-get update -q && \
    apt-get install unzip python-setuptools -qy

COPY root/ /
