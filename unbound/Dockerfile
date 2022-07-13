FROM debian:latest
LABEL maintainer="dragonchaser <autobuilds@datenschmutz.space>"
EXPOSE 5335/udp
RUN apt-get update \
  && apt-get -y install unbound netcat
COPY config.conf /etc/unbound/unbound.conf.d/
COPY entrypoint.sh /
ENTRYPOINT /entrypoint.sh
