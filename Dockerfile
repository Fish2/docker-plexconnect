FROM phusion/baseimage:0.9.20
MAINTAINER fish2
# FORK FROM rwohleb/docker-plexconnect on GitHub

# Set correct environment variables
ENV HOME /root
ENV DEBIAN_FRONTEND="noninteractive"
ENV PYTHONIOENCODING="UTF-8"
COPY install.sh /tmp

# Use baseimage-docker's init system.
CMD ["/sbin/my_init"]

# Install Update and Install Packages
RUN apt-get update && apt-get install -y git python python-dev python-imaging \

# Disable SSH
&& rm -rf /etc/service/sshd /etc/my_init.d/00_regen_ssh_host_keys.sh \

# Install PlexConnect
&& bash /tmp/install.sh \

# Clean Up
&& apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /etc/crontab /etc/service/cron /etc/cron.* && apt-get remove --purge -y python-dev cron && apt-get autoremove -y

# Ports, Entry Points and Volumes
EXPOSE 80 443 53
VOLUME /config
