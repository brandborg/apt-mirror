FROM ubuntu:14.04

MAINTAINER Guilherme Mitre <gmitre@gmail.com>

ENV MIRROR http://archive.ubuntu.com/ubuntu
ENV SYNC_TIME 24h
ENV WEBROOT /var/www/apt/

ENV DEBIAN_FRONTEND noninteractive

RUN \
  apt-get update && \
  apt-get install -y apache2 libapache2-mod-evasive apt-mirror && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/* && \
  mv /etc/apt/mirror.list /opt/ && \
  sed -i '/Directory \/var\/www\//aOrder Deny,Allow\nDeny from all\nAllow from 127.0.0.1\/32\nAllow from 10.0.0.0\/8\nAllow from 172.16.0.0\/12\nAllow from 192.168.0.0\/16' /etc/apache2/apache2.conf && \
  mkdir -p "$WEBROOT" && \
  sed -i 's/#DOSPageCount        2/DOSPageCount        10/g' /etc/apache2/mods-enabled/evasive.conf && \
  sed -i 's/#DOSSiteCount        50/DOSSiteCount        10/g' /etc/apache2/mods-enabled/evasive.conf && \
  sed -i 's/#DOSBlockingPeriod   10/DOSBlockingPeriod   1/g' /etc/apache2/mods-enabled/evasive.conf && \
  sed -i '12s|DocumentRoot /var/www/html|DocumentRoot /var/www/apt|' /etc/apache2/sites-enabled/000-default.conf


EXPOSE 80

COPY run.sh /run.sh

VOLUME ["/etc/apt", "/var/spool/apt-mirror"]
CMD ["/bin/bash", "run.sh"]
