FROM plexinc/pms-docker:latest
MAINTAINER Simon Hartcher <github.com/deevus>

ENV MASTER_IP=master_ip \
    MASTER_PORT=22 \
    MASTER_USER=plex \
    SLAVE_IP=slave_ip \
    SLAVE_PORT=22 \
    SLAVE_USER=plex

RUN apt-get update -q && \
    apt-get install unzip python-setuptools openssh-server iputils-ping vim -qy

RUN sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
#RUN echo "AuthorizedKeysFile /etc/ssh/%u/authorized_keys" > /etc/ssh/sshd_config

# SSH login fix. Otherwise user is kicked off after login
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

RUN mkdir /var/run/sshd
COPY slave/root/ /
COPY shared/ /
RUN rm -rf /etc/services.d/plex && \
    sed -i -e 's;/config:/bin/false;/config:/bin/bash;g' /etc/passwd

RUN echo "StrictHostKeyChecking no" >> /etc/ssh/ssh_config

EXPOSE 22
