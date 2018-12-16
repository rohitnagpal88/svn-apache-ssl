FROM debian:stretch-slim

RUN mkdir -p /usr/share/man/man1

RUN apt-get update && apt-get install wget gnupg iputils-ping nano -y

RUN apt-get update && apt-get install apache2 apache2-utils subversion subversion-tools libapache2-mod-svn -y

RUN mkdir /home/svn && mkdir /etc/apache2/ssl && chmod a+w /etc/subversion/* && chmod a+w /home/svn/

RUN a2enmod ssl

ADD svn.test.com.key /etc/apache2/ssl/svn.test.com.key
ADD svn.test.com.cert /etc/apache2/ssl/svn.test.com.cert
ADD dav_svn.conf /etc/apache2/mods-enabled/dav_svn.conf

EXPOSE 80 443

#Set enviroment variables
ENV APACHE_RUN_USER    www-data
ENV APACHE_RUN_GROUP   www-data
ENV APACHE_PID_FILE    /var/run/apache2.pid
ENV APACHE_RUN_DIR     /var/run/apache2
ENV APACHE_LOCK_DIR    /var/lock/apache2
ENV APACHE_LOG_DIR     /var/log/apache2
ENV LANG               C

CMD ["apache2", "-D", "FOREGROUND"]
