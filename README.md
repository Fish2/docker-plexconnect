# fish2/docker-plexconnect
[![](https://images.microbadger.com/badges/image/fish2/docker-plexconnect.svg)](https://microbadger.com/images/fish2/docker-plexconnect "Get your own image badge on microbadger.com")

**Purpose**
Create a Docker Container running the Plexconnect
This is a Docker setup for PlexConnect using https://github.com/Fish2/PlexConnect Fork
This Container is based on https://github.com/linuxserver/docker-baseimage-alpine-python

**Create Command**

	docker create --name=plexconnect --restart=always -v </path for config>:/config -e TZ=<timezone> -e PGID=<gid> -e PUID=<uid> -p 53:53/udp -p 80:80/tcp -p 443:443/tcp fish2/docker-plexconnect

**SSl**
Put your SSL certificates in </path for config>/config/certificates. If they do not exist the docker container will generate them for you.

**Credits**
fish2
linuxserver
