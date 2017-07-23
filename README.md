# Docker containers for Plex Media Server with Remote Transcoding Support

Using the [Official Plex docker container](https://github.com/plexinc/pms-docker/) as a base,
with remote transcoding support provided by [Plex Remote Transcoder](https://github.com/wnielson/Plex-Remote-Transcoder)
we pair the two together using Docker. 

The Official Plex docker image is the basis for both the master and slave, so their documentation also applies to these containers.
Given that, I won't repeat that information here.

## Prerequisites

- Docker

## Usage

### Master

```
docker run \
--name plex \
-p 32400:32400/tcp \
-p 3005:3005/tcp \
-p 8324:8324/tcp \
-p 32469:32469/tcp \
-p 1900:1900/udp \
-p 32410:32410/udp \
-p 32412:32412/udp \
-p 32413:32413/udp \
-p 32414:32414/udp \
-e TZ="<timezone>" \
-e PLEX_CLAIM="<claimToken>" \
-e ADVERTISE_IP="http://<hostIPAddress>:32400/" \
-e MASTER_IP="<hostIPAddress>" \
-e SLAVE_IP="<slaveIPAddress>" \
-e SLAVE_PORT="<slavePort>" \
-e SLAVE_USER="<slaveUser>" \
-e PLEX_UID="<plexUid>" \
-e PLEX_GID="<plexGid>" \
-v <path/to/plex/database>:/config \
-v <path/to/transcode/temp>:/transcode \
-v <path/to/tv/series>:/data/tvshows \
-v <path/to/movies>:/data/movies \
-v <path/to/another/media>:/data/mediaTypeA \
-v <path/to/some/other/media>:/data/mediaTypeB \
deevus/plex-remote-transcoder:master-latest
```

### Slave

```
docker run \
--name plex-slave \
-p 22:22 \
-e TZ="<timezone>" \
-e MASTER_IP="<hostIPAddress>" \
-e PLEX_UID="<plexUid>" \
-e PLEX_GID="<plexGid>" \
-v <path/to/plex/database>:/config \
-v <path/to/transcode/temp>:/transcode \
-v <path/to/tv/series>:/data/tvshows \
-v <path/to/movies>:/data/movies \
-v <path/to/another/media>:/data/mediaTypeA \
-v <path/to/some/other/media>:/data/mediaTypeB \
deevus/plex-remote-transcoder:slave-latest
```

#### NB. The volume paths inside the containers need to match! If they don't, it won't work. 

## Parameters

- For explanation of the base image parameters see [their documentation](https://github.com/plexinc/pms-docker/).
  - Pay particular attention to `PLEX_UID` and `PLEX_GID` as this can affect the slaves ability to transcode. 

### Master & Slave

- `-e MASTER_IP="<hostIPAddress>"` this is the externally visible ip address (or hostname) for the Plex master.

### Master

- `-e SLAVE_IP="<slaveIPAddress>"` this is the IP address (or hostname) of the Plex slave. 
- `-e SLAVE_PORT="<slavePort>"` this is the SSH port of the Plex slave (default = `22`).
- `-e SLAVE_USER="<slaveUser>"` this is the SSH user of the Plex slave (default = `plex`).

## Configuration

Getting up and running is very similar to the official image. 
If the slave is off, unreachable or not configured, the master server
will function exactly as the official Plex Media Server container. 
This means that you can start-up, or shut-down the slave(s) as needed.

When you start up the master for the first time, it will add the slave as per the given parameters. 
The `.prt.conf` will be available in the mounted `/config` directory so you can change it from your
host if need be.

At this stage you need to go into the master container and ssh to the slave. 
The reasons for which are outlined vaguely [here](https://github.com/wnielson/Plex-Remote-Transcoder/wiki/Ubuntu-Install). 

```
# connect to an interactive terminal in the master container
docker exec -ti plex bash
# ssh to the slave so that we can type "yes" and populate `known_hosts`
ssh <slaveUser>@<slaveIPAddress> -p <slavePort>
```

If all goes well (and you typed "yes") you should be connected to the slave via ssh. 

## How do I mount my volumes on my master server to my slave?

- NFS
- CIFS
- Anything you like

## Docker on Windows?

Not officially. Docker on Windows only allows you to mount local volumes that you have explicitly allowed in settings. 
This means mounting network volumes is out of the question.

...

However, I have created an [auxiliary slave image](https://github.com/deevus/docker-plex-remote-transcoder-nfs) 
that can be used to mount NFS shares inside the container. If you want a master image that can do the same thing, 
you'll have to ask nicely, but I didn't need it, so I didn't do it. 

## Docker on Mac?

Dunno, haven't tried it. The above solution for Windows might work. Let me know. 
