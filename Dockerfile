FROM lsiobase/alpine.python:3.7

# set maintainer label
LABEL maintainer="fish2"

# set python to use utf-8 rather than ascii.
ENV PYTHONIOENCODING="UTF-8"

# install app
RUN git clone https://github.com/Fish2/PlexConnect /app/plexconnect

# add local files
COPY root/ /

# ports and volumes
EXPOSE 80 443 53
WORKDIR /app/plexconnect
VOLUME /config
