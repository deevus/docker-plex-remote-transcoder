FROM justcontainers/base
MAINTAINER Simon Hartcher <github.com/deevus>

RUN apt-get update -q && \
    apt-get install unzip python-setuptools openssh-server -qy

RUN sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config

# SSH login fix. Otherwise user is kicked off after login
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

ADD https://github.com/wnielson/Plex-Remote-Transcoder/archive/master.zip /tmp/
RUN unzip /tmp/master.zip -d /tmp/ && \
    cd /tmp/Plex-Remote-Transcoder-master && \
    python setup.py install

RUN mkdir /var/run/sshd
COPY root/ /

EXPOSE 22
