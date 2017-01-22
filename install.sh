#!/bin/bash

# chfn workaround - Known issue within Dockers
ln -s -f /bin/true /usr/bin/chfn

[[ ! -d "/opt/plexconnect/.git" ]] && \
	git clone https://github.com/rwohleb/PlexConnect /opt/plexconnect

# Fix a Debianism of PlexConnect's uid being 101
usermod -u 99 plexconnect
usermod -g 100 plexconnect
usermod -d /home plexconnect
chown -R plexconnect:users /home
chown -R plexconnect:users /opt/plexconnect

# Add PlexConnect to runit
mkdir -p /etc/service/plexconnect
cat <<'EOT' > /etc/service/plexconnect/run
#!/bin/bash
umask 000

# Check if Settings.cfg file exists in /config.
if [ -f /config/Settings.cfg ]; then
  rm /opt/plexconnect/Settings.cfg
  ln -s /config/Settings.cfg /opt/plexconnect/Settings.cfg
else
  if [ -f /opt/plexconnect/Settings.cfg ]; then
    mv /opt/plexconnect/Settings.cfg /config/Settings.cfg
  else
    touch /config/Settings.cfg
  fi
  ln -s /config/Settings.cfg /opt/plexconnect/Settings.cfg
fi

# Check if ATVSettings.cfg file exists in /config.
if [ -f /config/ATVSettings.cfg ]; then
  rm /opt/plexconnect/ATVSettings.cfg
  ln -s /config/ATVSettings.cfg /opt/plexconnect/ATVSettings.cfg
else
  if [ -f /opt/plexconnect/ATVSettings.cfg ]; then
    mv /opt/plexconnect/ATVSettings.cfg /config/ATVSettings.cfg
  else
    touch /config/ATVSettings.cfg
  fi
  ln -s /config/ATVSettings.cfg /opt/plexconnect/ATVSettings.cfg
fi

# Check if SSL certificate files exist in /config.
if [ -f /config/certificates/trailers.pem ] ; then
  rm /opt/plexconnect/assets/certificates/trailers.key
  rm /opt/plexconnect/assets/certificates/trailers.pem
  rm /opt/plexconnect/assets/certificates/trailers.cer

  ln -s /config/certificates/trailers.key /opt/plexconnect/assets/certificates/trailers.key
  ln -s /config/certificates/trailers.pem /opt/plexconnect/assets/certificates/trailers.pem
  ln -s /config/certificates/trailers.cer /opt/plexconnect/assets/certificates/trailers.cer
else
  if [ ! -d /config/certificates ]; then
    mkdir /config/certificates
  fi
  if [ -f /opt/plexconnect/assets/certificates/trailers.pem ]; then
    mv /opt/plexconnect/assets/certificates/trailers.key /config/certificates/trailers.key
    mv /opt/plexconnect/assets/certificates/trailers.pem /config/certificates/trailers.pem
    mv /opt/plexconnect/assets/certificates/trailers.cer /config/certificates/trailers.cer
  else
    openssl req -new -nodes -newkey rsa:2048 -out /config/certificates/trailers.pem -keyout /config/certificates/trailers.key -x509 -days 7300 -subj "/C=US/CN=trailers.apple.com"
    openssl x509 -in /config/certificates/trailers.pem -outform der -out /config/certificates/trailers.cer && cat /config/certificates/trailers.key >> /config/certificates/trailers.pem
  fi

  ln -s /config/certificates/trailers.key /opt/plexconnect/assets/certificates/trailers.key
  ln -s /config/certificates/trailers.pem /opt/plexconnect/assets/certificates/trailers.pem
  ln -s /config/certificates/trailers.cer /opt/plexconnect/assets/certificates/trailers.cer
fi

# Give PlexConnect a chance to generate default settings files.
/usr/bin/python /opt/plexconnect/Settings.py
/usr/bin/python /opt/plexconnect/ATVSettings.py

# Run PlexConnect
exec /usr/bin/python /opt/plexconnect/PlexConnect.py
EOT
chmod +x /etc/service/plexconnect/run
