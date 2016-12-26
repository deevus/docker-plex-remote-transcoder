FROM plexinc/pms-docker:latest
MAINTAINER Simon Hartcher <github.com/deevus>

ADD https://github.com/wnielson/Plex-Remote-Transcoder/archive/master.zip /tmp/prt.zip
RUN apt-get update -q && \
    apt-get install unzip python-setuptools -qy
RUN unzip /tmp/prt.zip -d /home && \
    mv /home/Plex-Remote-Transcoder-master /home/Plex-Remote-Transcoder
WORKDIR /home/Plex-Remote-Transcoder
RUN python setup.py install