FROM phusion/baseimage:0.9.22
MAINTAINER fish2
# FORK FROM rwohleb/docker-plexconnect on GitHub

# Set correct environment variables
ENV HOME=/root \
    DEBIAN_FRONTEND="noninteractive"

# Use baseimage-docker's init system.
CMD ["/sbin/my_init"]

# Add Installer Script
COPY install.sh /tmp

# Install Update and Install Packages
RUN apt-get update && apt-get install -y git python python-dev python-imaging=3.3.2 \

# Disable SSH
&& rm -rf /etc/service/sshd /etc/my_init.d/00_regen_ssh_host_keys.sh \

# Install PlexConnect
&& bash /tmp/install.sh \

# Clean Up
&& apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /etc/crontab /etc/service/cron /etc/cron.* && apt-get remove --purge -y syslog-ng-core python-dev cron && apt-get autoremove -y \

# Disable syslog-ng
&& rm -rf /etc/service/syslog-ng

# Ports, Entry Points and Volumes
EXPOSE 53 80 443
VOLUME /config
