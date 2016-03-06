FROM phusion/baseimage:0.9.16
MAINTAINER snoopy <info@medved.in>

#########################################
##        ENVIRONMENTAL CONFIG         ##
#########################################

# Set correct environment variables
ENV HOME="/root" LC_ALL="C.UTF-8" LANG="en_US.UTF-8" LANGUAGE="en_US.UTF-8"

# Use baseimage-docker's init system
CMD ["/sbin/my_init"]

#########################################
##         RUN INSTALL SCRIPT          ##
#########################################
RUN apt-get update
RUN apt-get -f install git
RUN mkdir /tmp/lms
RUN git archive --remote=https://github.com/Logitech/slimserver-vendor.git CPAN /tmp/lms | tar xvf -
RUN chmod +x /tmp/lms/buildme.sh
RUN /tmp/lms/buildme.sh
COPY install.sh /tmp/
RUN chmod +x /tmp/install.sh; sync; /tmp/install.sh; sync; rm /tmp/install.sh

#########################################
##         EXPORTS AND VOLUMES         ##
#########################################
VOLUME /config /music
EXPOSE 3483 3483/udp 9000 9090