This is a Dockerfile setup for PlexConnect - https://github.com/CyberGhost84/PlexConnect

To run:

```
docker run -d --host="name" --name="plexconnect" -v /path/to/plexconnect/ssl:/opt/plexconnect/assets/certificates:rw -v /etc/localtime:/etc/localtime:ro -p 80:80 rwohleb/plexconnect
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

Put your SSL certificates in /path/to/plexconnect/ssl if they do not exist the docker will generate them for you.
