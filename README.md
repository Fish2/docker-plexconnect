# fish2/docker-plexconnect

This is a Docker setup for PlexConnect using the iBaa master.
https://github.com/rwohleb/PlexConnect

**sample create command:**

```
docker create --name=plexconnect --restart=always --net=host -v /docker/containers/plexconnect/config:/config:rw -e PGID=<gid> -e PUID=<uid> -e TZ=Europe/London -p 80:80 fish2/docker-plexconnect
```

**SSl**

Put your SSL certificates in /path/to/plexconnect/config/certificates. If they do not exist the docker image will generate them for you.

**Credits**

rwohleb <rob@tispork.com>
fish2
