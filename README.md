This is a Docker setup for PlexConnect using the rwohleb fork of the CyberGhost84 fork.
https://github.com/rwohleb/PlexConnect
https://github.com/CyberGhost84/PlexConnect

**sample create command:**

```
docker create --name=plexconnect --restart=always --net=host -v /docker/containers/plexconnect/config:/config:rw -e PGID=1000 -e PUID=1000 -e TZ=Europe/London -p 80:80 rwohleb/plexconnect
```

FIRST TIME USERS
---

** PlexConnect must listen on port 80 and port 443. So you must move the unRAID management interface to a new port. **

1. Edit /boot/config/go
2. Replace: /usr/local/sbin/emhttp &
3. With: /usr/local/sbin/emhttp -p XX & (where XX equals the port)
4. Shutdown your array
5. Reboot unRAID

RETURNING USERS
---

Put your SSL certificates in /path/to/plexconnect/config/certificates. If they do not exist the docker image will generate them for you.
