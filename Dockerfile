FROM lsiobase/alpine.python:3.7

# set maintainer label
LABEL maintainer="fish2"

# install app
RUN git clone --depth 1 -b autocerts https://github.com/Fish2/PlexConnect /app/plexconnect

# add local files
COPY root/ /

# ports and volumes
EXPOSE 80 443 53
VOLUME /config
