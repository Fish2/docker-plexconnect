# fish2/docker-plexconnect

**Purpose**
Create a container running the Plexconnect
This is a Docker setup for PlexConnect using https://github.com/rwohleb/PlexConnect fork Updated to use phusion/baseimage:0.9.19

**Create Command**

	docker create --name=plexconnect --restart=always --net=host -v </path for config>:/config:rw -e PGID=<gid> -e PUID=<uid> -e TZ=<timezone> -p 80:80 fish2/docker-plexconnect

**SSl**
Put your SSL certificates in /path/to/plexconnect/config/certificates. If they do not exist the docker image will generate them for you.

**Credits**
rwohleb <rob@tispork.com>
fish2
