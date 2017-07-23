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

RUN apt-get install openssh-server -qy

ENV MASTER_IP=master_ip

RUN sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN echo "AuthorizedKeysFile /etc/ssh/%u/authorized_keys" > /etc/ssh/sshd_config

# SSH login fix. Otherwise user is kicked off after login
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

RUN mkdir /var/run/sshd
COPY root/ /
RUN rm -rf /etc/services.d/plex && \
    sed -i -e 's;/config:/bin/false;/config:/bin/bash;g' /etc/passwd

EXPOSE 22
