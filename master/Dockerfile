FROM plexinc/pms-docker:latest
MAINTAINER Simon Hartcher <github.com/deevus>

ENV SLAVE_IP=slave_ip \
    SLAVE_PORT=22 \
    SLAVE_USER=plex \
    MASTER_IP=master_ip

RUN apt-get update -q && \
    apt-get install unzip python-setuptools openssh-client iputils-ping vim -qy

# Allow master to SSH to slave without a host key
RUN echo "StrictHostKeyChecking no" >> /etc/ssh/ssh_config

COPY root/ /

VOLUME /ssh
