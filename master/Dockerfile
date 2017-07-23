FROM plexinc/pms-docker:latest
MAINTAINER Simon Hartcher <github.com/deevus>

RUN apt-get update -q && \
    apt-get install unzip python-setuptools python-psutil openssh-client -qy

RUN curl -J -L -o /tmp/prt.zip https://github.com/wnielson/Plex-Remote-Transcoder/archive/master.zip && \
    unzip /tmp/prt.zip -d /tmp && \
    cd /tmp/Plex-Remote-Transcoder-master && \
    python setup.py install && \
    rm /tmp/prt.zip && \
    rm -rf /tmp/Plex-Remote-Transcoder-master && \
    cd /

ENV SLAVE_IP=slave_ip \
    SLAVE_PORT=22 \
    SLAVE_USER=plex \
    MASTER_IP=master_ip

COPY root/ /
