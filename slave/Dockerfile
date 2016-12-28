FROM plexinc/pms-docker:plexpass
MAINTAINER Simon Hartcher <github.com/deevus>

RUN apt-get update -q && \
    apt-get install unzip python-setuptools openssh-server -qy

RUN sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config

# SSH login fix. Otherwise user is kicked off after login
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

RUN mkdir /var/run/sshd
COPY root/ /
RUN rm -rf /etc/services.d/plex && \
    sed -i -e 's;/config:/bin/false;/config:/bin/bash;g' /etc/passwd

EXPOSE 22
