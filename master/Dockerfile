FROM plexinc/pms-docker:latest
MAINTAINER Simon Hartcher <github.com/deevus>

ENV MASTER_IP=master_ip

RUN apt-get update -q && \
    apt-get install unzip python-setuptools openssh-client iputils-ping vim -qy

RUN apt-get install openssh-server -qqy

RUN sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config

# SSH login fix. Otherwise user is kicked off after login
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd
RUN sed -i -e 's;/config:/bin/false;/config:/bin/bash;g' /etc/passwd

RUN mkdir /var/run/sshd

# Allow master to SSH to slave without a host key
RUN echo "StrictHostKeyChecking no" >> /etc/ssh/ssh_config

COPY master/root/ /
COPY shared/ /

EXPOSE 22
