# fish2/docker-plexconnect
[![](https://images.microbadger.com/badges/image/fish2/docker-plexconnect.svg)](https://microbadger.com/images/fish2/docker-plexconnect "Get your own image badge on microbadger.com")

**Purpose**
Create a container running the Plexconnect
This is a Docker setup for PlexConnect using https://github.com/Fish2/PlexConnect fork Updated to use phusion/baseimage:0.9.22

**Create Command**
```
	docker create --name=plexconnect --restart=always --net=host -v </path for config>:/config:rw -e PGID=<gid> -e PUID=<uid> -e TZ=<timezone> -p 80:80 fish2/docker-plexconnect
```

**SSl**
Put your SSL certificates in /path/to/plexconnect/config/certificates. If they do not exist the docker image will generate them for you.

**Updates**
This docker auto pulls updates on restart

**Credits**
fish2
