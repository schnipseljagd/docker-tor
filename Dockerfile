FROM ubuntu:trusty
MAINTAINER "Joscha Meyer <joscha@schnipseljagd.org>"

EXPOSE 9001
ENV VERSION 0.1

RUN apt-get update && apt-get install -y \
   tor \
   tor-arm

ADD ./torrc /etc/torrc
# Allow you to upgrade your relay without having to regenerate keys
VOLUME /.tor


# Generate a random nickname for the relay
RUN echo "Nickname docker$(head -c 16 /dev/urandom  | sha1sum | cut -c1-10)" >> /etc/torrc

CMD /usr/sbin/tor -f /etc/torrc
