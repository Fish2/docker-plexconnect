FROM lsiobase/alpine.python:3.7

# set maintainer label
LABEL maintainer="fish2"

# install app
RUN git clone --depth 1 https://github.com/iBaa/PlexConnect /app/plexconnect

# add local files
COPY root/ /

# ports and volumes
EXPOSE 80 443 53
VOLUME /config
HEALTHCHECK --interval=1m --timeout=3s CMD curl -sf http://localhost/ || exit 1
