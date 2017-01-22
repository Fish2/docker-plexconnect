FROM phusion/baseimage:0.9.19
MAINTAINER fish2
# FORK FROM rwohleb/docker-plexconnect on GitHub

# Set correct environment variables
ENV HOME /root
ENV DEBIAN_FRONTEND="noninteractive"
ENV PYTHONIOENCODING="UTF-8"
ENV LC_ALL C.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US.UTF-8

# Install Packages
RUN apt-get update && apt-get install -y python python-dev python-imaging git

# Disable SSH
RUN rm -rf /etc/service/sshd /etc/my_init.d/00_regen_ssh_host_keys.sh

# Install PlexConnect
ADD install.sh /
RUN bash /install.sh

# Clean Up
RUN apt-get clean all && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Use baseimage-docker's init system
CMD ["/sbin/my_init"]

# Ports, Entry Points and Volumes
EXPOSE 80 443 53
VOLUME /config
